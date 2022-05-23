//
//  Service.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 21.05.22.
//

import Foundation

final class Service {
    
    var name: String
    var price: Int
    var description: String
    var advantageHeader1: String
    var advantageBody1: String
    var advantageHeader2: String
    var advantageBody2: String
    var advantageHeader3: String
    var advantageBody3: String
    
    internal init(name: String, price: Int, description: String, advantageHeader1: String, advantageBody1: String, advantageHeader2: String, advantageBody2: String, advantageHeader3: String, advantageBody3: String) {
        self.name = name
        self.price = price
        self.description = description
        self.advantageHeader1 = advantageHeader1
        self.advantageBody1 = advantageBody1
        self.advantageHeader2 = advantageHeader2
        self.advantageBody2 = advantageBody2
        self.advantageHeader3 = advantageHeader3
        self.advantageBody3 = advantageBody3
    }
}
