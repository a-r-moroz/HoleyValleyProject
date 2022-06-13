//
//  DecorationType.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 4.05.22.
//

import Foundation

enum DecorationType {
    case shtanga
    case nostrill
    case circular
    case labret
    case kolco
    case banan
    case top
    
    var setType: String {
        switch self {
        case .shtanga:
            return "Штанга"
        case .nostrill:
            return "Нострилл"
        case .circular:
            return "Циркуляр"
        case .labret:
            return "Лабрет"
        case .kolco:
            return "Кольцо"
        case .banan:
            return "Банан"
        case .top:
            return "Топ"
        }
    }
}
