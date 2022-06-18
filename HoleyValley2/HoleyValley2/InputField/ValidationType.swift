//
//  ValidationType.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 7.06.22.
//

import Foundation

enum ValidationType: String {

    case name = "[A-zА-ЯЁа-яё]{2,30}"
//    case name = "[A-zА-я]{2,30}"
    case surname = "[A-zА-ЯЁа-яё]{3,30}"
//    case surname = "[A-zА-я]{3,30}"
    case phone = "^(\\+375)[\\s(]*(29|25|44|33)[)\\s]*\\d{3}[\\s-]?\\d{2}[\\s-]?\\d{2}$"
//    case email = "^[A-z0-9_.+-]+@[A-z0-9-]+(\\.[A-z0-9-]{2,})+$"
//    case time = "^(1d{1})*[:]*(00)$" // don't worked
    case none = "[\\S]"
}

// "^((8|\+7)[\- ]?)?(\(?\d{3}\)?[\- ]?)?[\d\- ]{7,10}$"
// "^(\\+375|80)(29|25|44|33)(\\d{3})(\\d{2})(\\d{2})$"
// "(\+7|8)[\s(]*\d{3}[)\s]*\d{3}[\s-]?\d{2}[\s-]?\d{2}"
