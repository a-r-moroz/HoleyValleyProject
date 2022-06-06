//
//  ValidationType.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 7.06.22.
//

import Foundation

enum ValidationType: String {

    case name = "[A-zА-я]{2,30}"
    case surname = "[A-zА-я]{3,30}"
    case phone = "^(\\+375|80)(29|25|44|33)(\\d{3})(\\d{2})(\\d{2})$"
    case email = "^[A-z0-9_.+-]+@[A-z0-9-]+(\\.[A-z0-9-]{2,})+$"
    case none = "[\\S]"
}
