//
//  Conctants.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 19.05.22.
//

import Foundation

struct Constants {
    static let appName = "HoleyValley"
    static let defaultImage = "https://firebasestorage.googleapis.com/v0/b/holeyvalleytest.appspot.com/o/decorations%2FdefaultImage.png?alt=media&token=dd3b9287-3524-4e9f-a35f-7ba48e30bd41"
    static let belRublesSign = " BYN"
    static let fbDecorationsPath = "decorations"
    static let fbServicesPath = "services"

    struct DecorationType {
        
        static let shtanga = "Штанга"
        static let nostrill = "Нострилл"
        static let circular = "Циркуляр"
        static let labret = "Лабрет"
        static let kolco = "Кольцо"
        static let banan = "Банан"
        static let top = "Топ"
    }
    
    
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
