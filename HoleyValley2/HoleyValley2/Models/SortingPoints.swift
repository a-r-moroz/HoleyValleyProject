//
//  SortingMenu.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 3.06.22.
//

import Foundation

//enum SortingPoints: CaseIterable {
//    case shtanga
//    case nostrill
//    case circular
//    case labret
//    case kolco
//    case banan
//    case top
//    case increasePrice
//    case decreasePrice
//
//    var typeString: String {
//        switch self {
//        case .shtanga:
//            return "Штанга"
//        case .nostrill:
//            return "Нострилл"
//        case .circular:
//            return "Циркуляр"
//        case .labret:
//            return "Лабрет"
//        case .kolco:
//            return "Кольцо"
//        case .banan:
//            return "Банан"
//        case .top:
//            return "Топ"
//        case .increasePrice:
//            return "Сначала дешевле"
//        case .decreasePrice:
//            return "Сначала дороже"
//        }
//    }
//}

enum SortingPoints: CaseIterable {
    case decorationType
    case price
    
    var sortingType: String {
        switch self {
        case .decorationType:
            return "Тип украшения"
        case .price:
            return "Стоимость украшения"
        }
    }
}
