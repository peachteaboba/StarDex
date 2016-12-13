//
//  ViewController.swift
//  StarDex
//
//  Created by Andy Feng on 8/11/16.
//  Copyright © 2016 Andy Feng. All rights reserved.
//

import UIKit
import Alamofire
import AudioToolbox



class HomeViewController: UIViewController {
    var peopleiImageCache = [String: UIImage]()

//    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!

    
    @IBOutlet weak var navigationView: UIView!
    
    @IBOutlet weak var navigationViewBottomConstraint: NSLayoutConstraint!
    
    
    @IBOutlet var navigationViewBox: [UIView]!
    
    @IBOutlet weak var upArrowIcon: UIImageView!
    
    @IBOutlet weak var quoteImg: UIImageView!
    

    
    // MARK: - Nav View Outlets ------------------------------------------------------------------
    
    // Top Header
    @IBOutlet weak var navBarHeader: UIView!
    
    // Nav bar button outlets
    @IBOutlet weak var peopleBox: UIView!
    @IBOutlet weak var filmBox: UIView!
    @IBOutlet weak var starshipBox: UIView!
    @IBOutlet weak var vehicleBox: UIView!
    @IBOutlet weak var speciesBox: UIView!
    @IBOutlet weak var planetBox: UIView!
    
    
    @IBOutlet weak var peopleImage: UIImageView!
    @IBOutlet weak var filmImage: UIImageView!
    @IBOutlet weak var starshipImage: UIImageView!
    @IBOutlet weak var vehicleImage: UIImageView!
    @IBOutlet weak var speciesImage: UIImageView!
    @IBOutlet weak var planetImage: UIImageView!
    
    
    // Icon image top constraints
    @IBOutlet var navIconTopConstraint: [NSLayoutConstraint]!
    
    
    
    
    @IBOutlet weak var navigationBarMainStackView: UIStackView!
   

    
    
    
    var navShowBottomConstraint:CGFloat = 0.0
    var menuStatus:String = ""
    
    
    
    
    @IBOutlet weak var containerView: UIView!
    weak var currentViewController: UIViewController?
    
    
    
    
    
    
    
    // MARK: - View did load -------------------------------------------------------------------------
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let rand = arc4random_uniform(3) + 1
        
        if rand == 1 {
            self.quoteImg.image = UIImage(named: "quote1")
        } else if rand == 2 {
            self.quoteImg.image = UIImage(named: "quote2")
        } else if rand == 3 {
            self.quoteImg.image = UIImage(named: "quote3")
        }
        
        

        
        // Set navigation icon top constraint
        for icon in self.navIconTopConstraint {
            icon.constant = self.view.frame.width * 0.05
        }
        
        
        
        
        self.upArrowIcon.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
        
        
        // Hide nav bar on first load
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = UIColor.white
        self.navigationView.backgroundColor = UIColorFromRGB(0x1a1d21)

        self.view.backgroundColor = UIColorFromRGB(0xEBF2F5)
        
  
        
        // Nav view box styles
        for box in self.navigationViewBox {
            box.layer.cornerRadius = 5
        }
        
        
        
        
        menuStatus = "up"
        
        let boxHeight = (self.view.frame.width - 40) / 3
        
        
        navShowBottomConstraint = -(self.navigationView.frame.height - ((boxHeight * 2) + 130))
        
        
        self.navigationViewBottomConstraint.constant = navShowBottomConstraint
        
        let navHeaderTap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.handleNavHeaderTap))
        self.navBarHeader.isUserInteractionEnabled = true
        self.navBarHeader.addGestureRecognizer(navHeaderTap)
        
        
        let peopleBoxTap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.handlePeopleBoxTap))
        self.peopleBox.isUserInteractionEnabled = true
        self.peopleBox.addGestureRecognizer(peopleBoxTap)
        
        
        let filmBoxTap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.handleFilmBoxTap))
        self.filmBox.isUserInteractionEnabled = true
        self.filmBox.addGestureRecognizer(filmBoxTap)
        
        let starshipBoxTap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.handleStarshipBoxTap))
        self.starshipBox.isUserInteractionEnabled = true
        self.starshipBox.addGestureRecognizer(starshipBoxTap)
        
        let vehicleBoxTap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.handleVehicleBoxTap))
        self.vehicleBox.isUserInteractionEnabled = true
        self.vehicleBox.addGestureRecognizer(vehicleBoxTap)

        let speciesBoxTap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.handleSpeciesBoxTap))
        self.speciesBox.isUserInteractionEnabled = true
        self.speciesBox.addGestureRecognizer(speciesBoxTap)

        let planetBoxTap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.handlePlanetBoxTap))
        self.planetBox.isUserInteractionEnabled = true
        self.planetBox.addGestureRecognizer(planetBoxTap)

        
        
        
        
        
        
        

        
      

        self.navigationView.layer.zPosition = 2
        
        
        
        
        // Instantiates the child view controller named “Component A”
        self.currentViewController = self.storyboard?.instantiateViewController(withIdentifier: "startVC")
        
        // Set the auto resizing mask appropriately on the view of the newly constructed child view controller for use with auto layout
        self.currentViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        
        
        // Add the child view controller to the parent view controller
        self.addChildViewController(self.currentViewController!)
        
        
        // Helper method to add a sub view to another view and constrain it with auto layout
        self.addSubview(self.currentViewController!.view, toView: self.containerView)
        
        
        
        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Helper Functions --------------------------------------------------------------------------------------------------------
    
    func animateMenuView(_ sender: String) {
        
        // SOMETHING TO REMEMBER FROM THE LECTURE :::::::::::::::::
        
        // sender.selected = !sender.selected
        
        // .constant = sender.selected ? 0 : -70
        
        // let buttonText = self.tabBarIsShowing ? "hide" : "show"
        // self.button.setTitle(buttonText, forState: UIControlState.Normal)
        
        
//        self.navigationController?.modalPresentationStyle = UIModalPresentationStyle.
        
        
        // :::::::::::::::::::::::::::::::::::::::::::::::::::::::::
        
        
        
  
        // Amimation -----------------
        // navigationViewBottomConstraint will start out at -300
        
        if sender == "box" {
            
            // Make phone vibrate when animation is triggered..
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            
            self.navigationViewBottomConstraint.constant = -(self.navigationView.frame.height - 80)
            menuStatus = "down"
            
            self.upArrowIcon.transform = CGAffineTransform(rotationAngle: CGFloat(0))
            
        } else if sender == "header" {
            
            if menuStatus == "up" {
                self.navigationViewBottomConstraint.constant = -(self.navigationView.frame.height - 80)
                self.upArrowIcon.transform = CGAffineTransform(rotationAngle: CGFloat(0))
                menuStatus = "down"
            } else {
                self.navigationViewBottomConstraint.constant = navShowBottomConstraint
                self.upArrowIcon.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
                menuStatus = "up"
            }
        }
        
        
     
        
        
        
        
        // Code to start animation
        self.view.setNeedsLayout()
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.45, initialSpringVelocity: 0.7, options: [UIViewAnimationOptions.allowUserInteraction], animations: {
            self.view.layoutIfNeeded()
        }) { (finished) in
            if finished {
                // Code to execute after animation...
            }
        }
        
        
    }
    
    
    
    
    func handleNavHeaderTap() {
//        print("Nav bar header pressed")
        animateMenuView("header")
    }
    
    
    func handlePeopleBoxTap() {
        self.quoteImg.isHidden = true
        
//        print("People box pressed")
        animateMenuView("box")
        
        // User pressed the people box. Switch the container view's child view to display peopleVC
        let newViewController = self.storyboard!.instantiateViewController(withIdentifier: "peopleVC") as! PeopleViewController
        newViewController.imageCache = self.peopleiImageCache
        newViewController.view.translatesAutoresizingMaskIntoConstraints = false
        setImageColor("people")
        
        
        // Helper method to do the transition
        self.cycleFromViewController(self.currentViewController!, toViewController: newViewController)
        
        self.currentViewController = newViewController
        
    }
    
    func handleFilmBoxTap() {
        self.quoteImg.isHidden = true
        animateMenuView("box")
        let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "filmVC")
        newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        setImageColor("film")

        // Helper method to do the transition
        self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
        self.currentViewController = newViewController
    }
    
    func handleStarshipBoxTap() {
        self.quoteImg.isHidden = true
        animateMenuView("box")
        let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "starshipVC")
        newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        setImageColor("starship")
        
        // Helper method to do the transition
        self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
        self.currentViewController = newViewController
    }
    
    func handleVehicleBoxTap() {
        self.quoteImg.isHidden = true
        animateMenuView("box")
        let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "vehicleVC")
        newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        setImageColor("vehicle")
        
        // Helper method to do the transition
        self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
        self.currentViewController = newViewController
    }
    
    func handleSpeciesBoxTap() {
        self.quoteImg.isHidden = true
        animateMenuView("box")
        let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "speciesVC")
        newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        setImageColor("species")
        
        // Helper method to do the transition
        self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
        self.currentViewController = newViewController
    }
    
    func handlePlanetBoxTap() {
        self.quoteImg.isHidden = true
        animateMenuView("box")
        let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "planetVC")
        newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        setImageColor("planet")
        
        // Helper method to do the transition
        self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
        self.currentViewController = newViewController
    }
    
    
    
    
    
    
    
    
    
    
    
    // Helper function to set image colors
    
    func setImageColor (_ sender: String) {
        
        self.peopleImage.image = UIImage(named: "peopleIconW")
        self.filmImage.image = UIImage(named: "filmIconW")
        self.starshipImage.image = UIImage(named: "starshipIconW")
        self.vehicleImage.image = UIImage(named: "vehicleIconW")
        self.speciesImage.image = UIImage(named: "speciesIconW")
        self.planetImage.image = UIImage(named: "planetIconW")
        
        if sender == "people" {
            self.peopleImage.image = UIImage(named: "peopleIconC")
        } else if sender == "film" {
             self.filmImage.image = UIImage(named: "filmIconC")
        } else if sender == "starship" {
            self.starshipImage.image = UIImage(named: "starshipIconC")
        } else if sender == "vehicle" {
            self.vehicleImage.image = UIImage(named: "vehicleIconC")
        } else if sender == "species" {
            self.speciesImage.image = UIImage(named: "speciesIconC")
        } else {
            self.planetImage.image = UIImage(named: "planetIconC")
        }
        
    }
    
    
    

    
    
    
    
    
    
    // Helper function to set colors with Hex values
    func UIColorFromRGB(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    
    func addSubview(_ subView:UIView, toView parentView:UIView) {
        parentView.addSubview(subView)
        
        var viewBindingsDict = [String: AnyObject]()
        viewBindingsDict["subView"] = subView
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subView]|",
            options: [], metrics: nil, views: viewBindingsDict))
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subView]|",
            options: [], metrics: nil, views: viewBindingsDict))
    }
    
    
    
    
    
    
    
   
   
    
    
    // Helper function to do transitions between Container View views
    
    func cycleFromViewController(_ oldViewController: UIViewController, toViewController newViewController: UIViewController) {
        
        oldViewController.willMove(toParentViewController: nil)
        self.addChildViewController(newViewController)
        self.addSubview(newViewController.view, toView:self.containerView!)
        
        
        // Set the starting state of your constraints here
        newViewController.view.alpha = 0
        newViewController.view.layoutIfNeeded()
        
       
        
        UIView.animate(withDuration: 0.1, delay: 0, options: [], animations: {
            
            // only need to call layoutIfNeeded here
            newViewController.view.layoutIfNeeded()
            
            // Set the ending state of your constraints here
            newViewController.view.alpha = 1
            oldViewController.view.alpha = 0
            
            },
            completion: { finished in
                oldViewController.view.removeFromSuperview()
                oldViewController.removeFromParentViewController()
                newViewController.didMove(toParentViewController: self)
            })

    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
    

}

