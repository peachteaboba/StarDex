//
//  PeopleViewController.swift
//  StarDex
//
//  Created by Andy Feng on 8/13/16.
//  Copyright © 2016 Andy Feng. All rights reserved.
//

import UIKit
import Alamofire

class PeopleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var imageCache = [String: UIImage]()
    
    
    
    // Table data variables
    var people = [Person]()
    
    var resultsArray:NSArray = []
    var imgurResultsArray:NSArray = ["hello"]
    
    // API call count
    var callCount:CGFloat = 0.0
    
    var peopleImageJSON:AnyObject?
    
    
    
    @IBOutlet weak var topHeaderView: UIView!
    @IBOutlet weak var peopleTableView: UITableView!
    @IBOutlet weak var topLeftLabel: UILabel!
    
  
    @IBOutlet weak var loadingBar: UIView!
    @IBOutlet weak var loadingBarHead: UIView!
    @IBOutlet weak var loadingBarWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var loadingBarLeadingConstraint: NSLayoutConstraint!

    
    
    
    // MARK: - Table View Prototype Functions ------------------------------------------------
    
    // How many cells are we going to need?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    // How should I create each cell?
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Dequeue the cell from our storyboard
        let cell = tableView.dequeueReusableCell(withIdentifier: "peopleCell") as! CustomPersonCell
        
        
        // Set table data
        cell.nameLabel.text = people[indexPath.row].name
        
        
        
        if people[indexPath.row].height == 0.0 {
            cell.heightLabel.text = "???"
        } else {
            cell.heightLabel.text = "\(people[indexPath.row].height / 100)"
        }
        
        
        if people[indexPath.row].mass == 0.0 {
            cell.massLabel.text = "???"
        } else {
            cell.massLabel.text = "\(people[indexPath.row].mass)"
        }

        
        
        
        // Check to see if image is cached. If it is, then assign the cached image, otherwise use default image
        if let img = imageCache[people[indexPath.row].name] {
            cell.imageLabel.image = img
        } else {
            cell.imageLabel.image = UIImage(named: "anon")
        }
        
        

        
        let path = UIBezierPath(roundedRect:cell.imageLabel.bounds, byRoundingCorners:[.topLeft, .bottomLeft], cornerRadii: CGSize(width: 5, height: 5))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        cell.imageLabel.layer.mask = maskLayer

        cell.contentViewLabel.layer.cornerRadius = 5
        
        // Return cell so that Table View knows what to draw in each row
        return cell
    }

    
    
    
    
    
    // MARK: - Make HTTP request to SWAPI ------------------------------------------------------
    
    

    
    
    // Make the API call to SWAPI, the People class with incoming data and stuff everything into the self.people array
    
    func makeAPICall(_ httpAddress: String){
        

        Alamofire.request(httpAddress, method: .get, parameters: nil, headers: nil)
            .responseJSON { response in
                
                // Perform action on API data
                if let jsonResult = response.result.value as? NSDictionary {
                    
                    // Take the results of the API call and jam it into the people array
                    if let results = jsonResult["results"] {
                        self.resultsArray = results as! NSArray
                        
                        for dataObject in self.resultsArray {
                            if let data = dataObject as? NSDictionary {

                                
                                // Inflate People class with corresponding API data for each character ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
                                
                                // Initialize dictionary variables
                                var dataDic = Dictionary<String, String>()
                                var dataArrDic = Dictionary<String, [String]>()
                                
                                
                                if let hair_color = data["hair_color"] as? String{
                                    dataDic["hair_color"] = hair_color
                                } else {
                                    dataDic["hair_color"] = "unknown"
                                }
                                
                                if let skin_color = data["skin_color"] as? String{
                                    dataDic["skin_color"] = skin_color
                                } else {
                                    dataDic["skin_color"] = "unknown"
                                }
                                
                                if let eye_color = data["eye_color"] as? String{
                                    dataDic["eye_color"] = eye_color
                                } else {
                                    dataDic["eye_color"] = "unknown"
                                }

                                if let birth_year = data["birth_year"] as? String{
                                    dataDic["birth_year"] = birth_year
                                } else {
                                    dataDic["birth_year"] = "unknown"
                                }
                                
                                if let gender = data["gender"] as? String{
                                    dataDic["gender"] = gender
                                } else {
                                    dataDic["gender"] = "unknown"
                                }
                                
                                if let homeworld = data["homeworld"] as? String{
                                    dataDic["homeworld"] = homeworld
                                } else {
                                    dataDic["homeworld"] = "unknown"
                                }
                                
                                
                                if let films = data["films"] as? [String]{
                                    dataArrDic["films"] = films
                                } else {
                                    dataArrDic["films"] = []
                                }
                                
                                if let species = data["species"] as? [String]{
                                    dataArrDic["species"] = species
                                } else {
                                    dataArrDic["species"] = []
                                }
                                
                                if let vehicles = data["vehicles"] as? [String]{
                                    dataArrDic["vehicles"] = vehicles
                                } else {
                                    dataArrDic["vehicles"] = []
                                }
                                
                                if let starships = data["starships"] as? [String]{
                                    dataArrDic["starships"] = starships
                                } else {
                                    dataArrDic["starships"] = []
                                }
                                
                                
                                let dataToInsert = Person(name: data["name"] as! String, height: ((data["height"] as AnyObject).doubleValue)!, mass: ((data["mass"] as AnyObject).doubleValue)!, data: dataDic, dataArr: dataArrDic)
                                

                                self.people.append(dataToInsert)
                                
                                
                                // :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
                                
                                
                                
    
                            }
                            // Update UI
                            self.peopleTableView.reloadData()
                            self.topLeftLabel.text = "\(self.people.count)"
                        }
                    }
                    

                    // Make repeat API calls until there is no next page to call
                    if let nextURL = jsonResult["next"] as? String{
                        self.makeAPICall(nextURL)
                    } else {
                        
                        // Done loading all data from the API. Cache it in AppDelegate
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.people = self.people
                        
                        
                        
                        
                        // Make the loading bar full width when there is no more next page to load
                        self.loadingBarWidthConstraint.constant = self.view.frame.width
                    }

                }
        }
        
        
        // Update loading bar
        self.callCount = self.callCount + 1.0
        self.loadingBarLeadingConstraint.constant = 0
        self.loadingBarWidthConstraint.constant = ((self.view.frame.width / 9.0) * self.callCount) - (self.view.frame.width / 9.0)
    
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - View Did Load ----------------------------------------------------------------
    
    override func viewDidLoad() {

     
        super.viewDidLoad()
        self.view.backgroundColor = UIColorFromRGB(0x325cd3)
        
        
        self.loadingBarWidthConstraint.constant = 0
        self.loadingBarLeadingConstraint.constant = 0
        
        self.loadingBarHead.layer.cornerRadius = 6
        
        self.loadingBarHead.backgroundColor = UIColorFromRGB(0xffffff)
        self.loadingBarHead.layer.borderWidth = 2
        self.loadingBarHead.layer.borderColor = UIColorFromRGB(0x44bd42).cgColor
        
        
        self.loadingBar.backgroundColor = UIColorFromRGB(0xffffff)
        self.loadingBar.layer.borderWidth = 2
        self.loadingBar.layer.borderColor = UIColorFromRGB(0x44bd42).cgColor
        
        
        
        self.topLeftLabel.text = "\(people.count)"
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        // If the people data is not cached, then go ahead and make the call to SWAPI
        if appDelegate.people.count == 0 {
            self.makeAPICall("http://swapi.co/api/people/")
        } else {
            // People data is already cached, use the cached data
            self.people = appDelegate.people
            // Make the loading bar full width and set the top left number label since all the data is there
            self.topLeftLabel.text = "\(self.people.count)"
            self.loadingBarWidthConstraint.constant = self.view.frame.width + 20
        }
        
        
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Helper Functions ------------------------------------------------------------
    
    // Helper function to set colors with Hex values
    func UIColorFromRGB(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    
    
    
    
}

