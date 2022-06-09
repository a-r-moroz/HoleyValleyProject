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
    var advantageHeaderFirst: String
    var advantageBodyFirst: String
    var advantageHeaderSecond: String
    var advantageBodySecond: String
    var advantageHeaderThird: String
    var advantageBodyThird: String
    
    internal init(name: String, price: Int, description: String, advantageHeaderFirst: String, advantageBodyFirst: String, advantageHeaderSecond: String, advantageBodySecond: String, advantageHeaderThird: String, advantageBodyThird: String) {
        self.name = name
        self.price = price
        self.description = description
        self.advantageHeaderFirst = advantageHeaderFirst
        self.advantageBodyFirst = advantageBodyFirst
        self.advantageHeaderSecond = advantageHeaderSecond
        self.advantageBodySecond = advantageBodySecond
        self.advantageHeaderThird = advantageHeaderThird
        self.advantageBodyThird = advantageBodyThird
    }
}
