//
//  Conctants.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 19.05.22.
//

import Foundation
import UIKit

struct Const {
    static let appName = "HoleyValley"
    static let defaultImage = "https://firebasestorage.googleapis.com/v0/b/holeyvalleytest.appspot.com/o/decorations%2FdefaultImage.png?alt=media&token=dd3b9287-3524-4e9f-a35f-7ba48e30bd41"
    static let belRublesSign = " BYN"

    struct DecorationType {
        
        static let shtanga = "Штанга"
        static let nostrill = "Нострилл"
        static let circular = "Циркуляр"
        static let labret = "Лабрет"
        static let kolco = "Кольцо"
        static let banan = "Банан"
        static let top = "Топ"
    }
    
    struct Colors {
        
        static let gray: UIColor = UIColor(red: 67/255, green: 67/255, blue: 67/255, alpha: 1)
    }
    
    struct CornerRadiusTo {
        
        static let viewAndImage: CGFloat = 18
    }
    
    struct Firebase {
        
        static let decorationsPath = "decorations"
        static let servicesPath = "services"
        static let appointmentsPath = "appointments"
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
