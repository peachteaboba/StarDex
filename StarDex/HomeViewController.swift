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
    
    
    

    
    // MARK: - Nav View Outlets
    
    @IBOutlet weak var navBarHeader: UIView!
    
    
    @IBOutlet weak var peopleView: UIView!
    @IBOutlet weak var filmBox: UIView!
    
    
    
    
    
    
    
    
    
    @IBOutlet weak var navigationBarMainStackView: UIStackView!
   
    
    
    @IBOutlet weak var navViewBoxSingle: UIView!
    
    
    
    var navShowBottomConstraint:CGFloat = 0.0
    var menuStatus:String = ""
    
    
    
    
    @IBOutlet weak var containerView: UIView!
    weak var currentViewController: UIViewController?
    
    
    
    
    
    // MARK: - Helper Functions
    
    func animateMenuView(sender: String) {
        
        print(menuStatus)
        
        // Make phone vibrate when animation is triggered..
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        // Amimation -----------------
        // navigationViewBottomConstraint will start out at -300
        
        if sender == "box" {
            
            self.navigationViewBottomConstraint.constant = -(self.navigationView.frame.height - 80)
            menuStatus = "down"
            
        } else if sender == "header" {
            
            if menuStatus == "up" {
                self.navigationViewBottomConstraint.constant = -(self.navigationView.frame.height - 80)
                menuStatus = "down"
            } else {
                self.navigationViewBottomConstraint.constant = navShowBottomConstraint
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
    
    
    
    
    
    
    
    func handlePeopleBoxTap() {
        print("People box pressed")
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
        
   
    }
    
    func handleFilmBoxTap() {
        animateMenuView("box")
        let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("filmVC")
        newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        
        // Helper method to do the transition
        self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
        self.currentViewController = newViewController
    }
    
    
    
    
    func handleNavHeaderTap() {
        print("Nav bar header pressed")
        animateMenuView("header")
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
        self.peopleView.userInteractionEnabled = true
        self.peopleView.addGestureRecognizer(peopleBoxTap)
        
        
        let filmBoxTap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.handleFilmBoxTap))
        self.filmBox.userInteractionEnabled = true
        self.filmBox.addGestureRecognizer(filmBoxTap)
        
        
        
        
        
        
        
        
        
        
        
        
        

        
      

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

