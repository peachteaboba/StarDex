//
//  PeopleViewController.swift
//  StarDex
//
//  Created by Andy Feng on 8/12/16.
//  Copyright © 2016 Andy Feng. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    var myVC: HomeViewController?
    
    
    
    

    // Dismiss the current view controller and return to the layer under it
    @IBAction func buttonPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    
     
    
    
    // MARK: - Defaults
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blue
        view.isOpaque = false
        self.view.layer.zPosition = 0
        
//        self.view.bringSubviewToFront((self.myVC?.navigationView)!)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
}
