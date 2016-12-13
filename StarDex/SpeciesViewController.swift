//
//  SpeciesViewController.swift
//  StarDex
//
//  Created by Andy Feng on 8/13/16.
//  Copyright © 2016 Andy Feng. All rights reserved.
//

import UIKit
import Alamofire

class SpeciesViewController: UIViewController {
    
    
    

    
    
    
    
    
    // MARK: - View Did Load ----------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColorFromRGB(0xf2824b)
        
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

