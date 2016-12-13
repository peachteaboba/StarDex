//
//  loadingScreenViewController.swift
//  StarDex
//
//  Created by Andy Feng on 8/15/16.
//  Copyright © 2016 Andy Feng. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class LoadingScreenViewController: UIViewController {
    
    
    @IBOutlet weak var loadingBarLabel: UIView!

    

    
    // This bad goes out into the world and caches some images for me.
    func startLoadingStuff(){
        // Go grab the people image url's from Andy's API
        Alamofire.request("http://www.andyfeng.com/peopleImageLinks", method: .get, parameters: nil, headers: nil)
            .responseJSON { response in
                
                // This puts the JSON data into an NSDictionary
                let peopleImageJSON = response.result.value! as! NSDictionary
                
                var theCache = [String: UIImage]()

                // Iterate over the NSDictionary and cache the actual image files from the url
                for (key, value) in peopleImageJSON {

                    // Use Alamofire to GET the image from the imgur url ----------------------------------
                    Alamofire.request(value as! String, method: .get, parameters: nil, headers: nil)
                        .responseImage { response in
                            if let image = response.result.value {
                                theCache[key as! String] = image
                                
                                // Do this after all the images are cached
                                if theCache.count == peopleImageJSON.count {
                                    self.handleCachePopulated(theCache)
                                }
                            }
                    } // ----------------------------------------------------------------------------------
                }
        }
    }
    
    
    
    
    
    func handleCachePopulated(_ imageCache: [String: UIImage]) {
        
        // Instantiate appDel and homeScreen constants
        let appDel = (UIApplication.shared).delegate as! AppDelegate
        let homeScreen = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
        
        
        // Assign to cached data to homescreen
        homeScreen.peopleiImageCache = imageCache
        
        
        // Call method in AppDelegate.swift to transition to the Home View Controller
        appDel.moveToVC(homeScreen)
        
    }
    
    
    
    
    // MARK: - View Did Load ----------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        // Set some styling
        self.loadingBarLabel.backgroundColor = UIColorFromRGB(0x231f20)
        
        
        startLoadingStuff()
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

