//
//  FavoriteDecoration.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 8.07.22.
//

import Foundation
import RealmSwift

class FavoriteDecoration: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var price: Int = 0
    @objc dynamic var descrip: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var isLiked: Bool = false
}
