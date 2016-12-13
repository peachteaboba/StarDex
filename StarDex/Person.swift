//
//  Person.swift
//  StarDex
//
//  Created by Andy Feng on 8/14/16.
//  Copyright © 2016 Andy Feng. All rights reserved.
//

import UIKit

class Person {
   
    var name: String
    var height: Double
    var mass: Double
    
    var hair_color: String
    var skin_color: String
    var eye_color: String
    var birth_year: String
    var gender: String
    var homeworld: String
    
    
    var films: [String]
    var species: [String]
    var vehicles: [String]
    var starships: [String]
    

    
    
    
    init(name: String, height: Double, mass: Double, data: Dictionary<String, String>, dataArr: Dictionary<String, [String]>){

        self.name = name
        self.height = height
        self.mass = mass
        
        self.hair_color = data["hair_color"]!
        self.skin_color = data["skin_color"]!
        self.eye_color = data["eye_color"]!
        self.birth_year = data["birth_year"]!
        self.gender = data["gender"]!
        self.homeworld = data["homeworld"]!
        
        
        self.films = dataArr["films"]!
        self.species = dataArr["species"]!
        self.vehicles = dataArr["vehicles"]!
        self.starships = dataArr["starships"]!
        
        
    }
    
}
