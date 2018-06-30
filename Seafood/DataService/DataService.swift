//
//  DataService.swift
//  HotDogZ!
//
//  Created by McKinney family  on 6/30/18.
//  Copyright © 2018 FasTek Technologies. All rights reserved.
//

import Foundation

class DataService {
    
    static let instances = DataService()
    
    private let rabbit = [animalClasses(names: "rabbit", rightResults: "It's a rabbit", wrongResults: "it's not a a rabbit ")
    ]
    private let dog = [animalClasses(names: "terrier", rightResults: "It's Dog!", wrongResults: "It's not a dog")
    ]
    
    
}
