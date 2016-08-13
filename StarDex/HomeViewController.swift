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
    

//    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!

    
    @IBOutlet weak var navigationView: UIView!
    
    @IBOutlet weak var navigationViewBottomConstraint: NSLayoutConstraint!
    
    
    @IBOutlet var navigationViewBox: [UIView]!
    
    @IBOutlet weak var upArrowIcon: UIImageView!
    
    

    
    // MARK: - Nav View Outlets ------------------------------------------------------------------
    
    // Top Header
    @IBOutlet weak var navBarHeader: UIView!
    
    // Nav bar buttons
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
    
    
    
    
    
    
    
    @IBOutlet weak var navigationBarMainStackView: UIStackView!
   

    
    
    
    var navShowBottomConstraint:CGFloat = 0.0
    var menuStatus:String = ""
    
    
    
    
    @IBOutlet weak var containerView: UIView!
    weak var currentViewController: UIViewController?
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.upArrowIcon.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        
        
        // Hide nav bar on first load
        self.navigationController?.navigationBarHidden = true
        self.view.backgroundColor = UIColor.whiteColor()
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
        self.navBarHeader.userInteractionEnabled = true
        self.navBarHeader.addGestureRecognizer(navHeaderTap)
        
        
        let peopleBoxTap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.handlePeopleBoxTap))
        self.peopleBox.userInteractionEnabled = true
        self.peopleBox.addGestureRecognizer(peopleBoxTap)
        
        
        let filmBoxTap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.handleFilmBoxTap))
        self.filmBox.userInteractionEnabled = true
        self.filmBox.addGestureRecognizer(filmBoxTap)
        
        let starshipBoxTap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.handleStarshipBoxTap))
        self.starshipBox.userInteractionEnabled = true
        self.starshipBox.addGestureRecognizer(starshipBoxTap)
        
        let vehicleBoxTap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.handleVehicleBoxTap))
        self.vehicleBox.userInteractionEnabled = true
        self.vehicleBox.addGestureRecognizer(vehicleBoxTap)

        let speciesBoxTap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.handleSpeciesBoxTap))
        self.speciesBox.userInteractionEnabled = true
        self.speciesBox.addGestureRecognizer(speciesBoxTap)

        let planetBoxTap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.handlePlanetBoxTap))
        self.planetBox.userInteractionEnabled = true
        self.planetBox.addGestureRecognizer(planetBoxTap)

        
        
        
        
        
        
        

        
      

        self.navigationView.layer.zPosition = 2
        
        
        
        
        // Instantiates the child view controller named “Component A”
        self.currentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("startVC")
        
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
    
    func animateMenuView(sender: String) {
        
  
        // Amimation -----------------
        // navigationViewBottomConstraint will start out at -300
        
        if sender == "box" {
            
            // Make phone vibrate when animation is triggered..
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            
            self.navigationViewBottomConstraint.constant = -(self.navigationView.frame.height - 80)
            menuStatus = "down"
            
            self.upArrowIcon.transform = CGAffineTransformMakeRotation(CGFloat(0))
            
        } else if sender == "header" {
            
            if menuStatus == "up" {
                self.navigationViewBottomConstraint.constant = -(self.navigationView.frame.height - 80)
                self.upArrowIcon.transform = CGAffineTransformMakeRotation(CGFloat(0))
                menuStatus = "down"
            } else {
                self.navigationViewBottomConstraint.constant = navShowBottomConstraint
                self.upArrowIcon.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
                menuStatus = "up"
            }
        }
        
        
     
        
        
        
        
        // Code to start animation
        self.view.setNeedsLayout()
        UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 0.45, initialSpringVelocity: 0.7, options: [], animations: {
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
//        print("People box pressed")
        animateMenuView("box")
        
        // User pressed the people box. Switch the container view's child view to display peopleVC
        
        let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("peopleVC")
        
        newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        
        // Helper method to do the transition
        self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
        
        self.currentViewController = newViewController

        
//        let peopleVC = self.storyboard?.instantiateViewControllerWithIdentifier("PeopleVC") as! PeopleViewController
//        peopleVC.modalPresentationStyle = .OverCurrentContext
//        showDetailViewController(peopleVC, sender: peopleVC)
//        self.navigationView.layer.zPosition = 1
//        peopleVC.myVC = self
        
        
        
        
        setImageColor("people")
        
   
    }
    
    func handleFilmBoxTap() {
        animateMenuView("box")
        let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("filmVC")
        newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        setImageColor("film")

        // Helper method to do the transition
        self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
        self.currentViewController = newViewController
    }
    
    func handleStarshipBoxTap() {
        animateMenuView("box")
        let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("starshipVC")
        newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        setImageColor("starship")
        
        // Helper method to do the transition
        self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
        self.currentViewController = newViewController
    }
    
    func handleVehicleBoxTap() {
        animateMenuView("box")
        let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("vehicleVC")
        newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        setImageColor("vehicle")
        
        // Helper method to do the transition
        self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
        self.currentViewController = newViewController
    }
    
    func handleSpeciesBoxTap() {
        animateMenuView("box")
        let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("speciesVC")
        newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        setImageColor("species")
        
        // Helper method to do the transition
        self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
        self.currentViewController = newViewController
    }
    
    func handlePlanetBoxTap() {
        animateMenuView("box")
        let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("planetVC")
        newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        setImageColor("planet")
        
        // Helper method to do the transition
        self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
        self.currentViewController = newViewController
    }
    
    
    
    
    
    
    
    
    
    
    
    // Helper function to set image colors
    
    func setImageColor (sender: String) {
        
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
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    
    func addSubview(subView:UIView, toView parentView:UIView) {
        parentView.addSubview(subView)
        
        var viewBindingsDict = [String: AnyObject]()
        viewBindingsDict["subView"] = subView
        parentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[subView]|",
            options: [], metrics: nil, views: viewBindingsDict))
        parentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[subView]|",
            options: [], metrics: nil, views: viewBindingsDict))
    }
    
    
    
    
    
    
    
   
   
    
    
    // Helper function to do transitions between child views
    
    func cycleFromViewController(oldViewController: UIViewController, toViewController newViewController: UIViewController) {
        
        oldViewController.willMoveToParentViewController(nil)
        self.addChildViewController(newViewController)
        self.addSubview(newViewController.view, toView:self.containerView!)
        
        
        // Set the starting state of your constraints here
        newViewController.view.alpha = 0
        newViewController.view.layoutIfNeeded()
        
        // Set the ending state of your constraints here
        newViewController.view.alpha = 1
        oldViewController.view.alpha = 0
        
        
        
        UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 0.45, initialSpringVelocity: 0.7, options: [], animations: {
            
            // only need to call layoutIfNeeded here
            newViewController.view.layoutIfNeeded()

            },
            completion: { finished in
                oldViewController.view.removeFromSuperview()
                oldViewController.removeFromParentViewController()
                newViewController.didMoveToParentViewController(self)
            })

    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
    

}

