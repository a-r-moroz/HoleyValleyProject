//
//  Decorations.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 3.05.22.
//

import Foundation
import UIKit
//import RealmSwift
//
//@objc final class Decorations: Object {
//
//    @objc dynamic var name = ""
//    @objc dynamic var price = 1
//    @objc dynamic var text: String?
//    @objc dynamic var picture: Data?
//}

class Decoration {

    var name: String
    var price: Int
    var describtion: String
    var type: String
    var image: String
    
    internal init(name: String, price: Int, describtion: String, type: String, image: String) {
        self.name = name
        self.price = price
        self.describtion = describtion
        self.type = type
        self.image = image
    }
}
