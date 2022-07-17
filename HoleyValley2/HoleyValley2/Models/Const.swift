//
//  Conctants.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 19.05.22.
//

import Foundation
import UIKit

struct Const {
    
    static let defaultImage = "https://firebasestorage.googleapis.com/v0/b/holeyvalleytest.appspot.com/o/decorations%2FdefaultImage.png?alt=media&token=dd3b9287-3524-4e9f-a35f-7ba48e30bd41"
    static let belRublesSign = " BYN"
    static let openingHours = ["12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00"]
    static let salonAddress = "Кальварийская улица, 25, 302"
    static let salonPhoneNumber = "+375 (33) 990-77-88"
    static let salonPhoneNumberNoSpaces = "375339907788"
    static let appName = "HoleyValley"
    
    struct tabBarItemTitles {
        
        static let firstItem = "Услуги"
        static let secondItem = "Каталог"
        static let thirdItem = "Контакты"
        static let fourthItem = "Профиль"
    }
    
    struct DecorationType {
        
        static let defaultType = "Все украшения"
        static let shtanga = "Штанга"
        static let nostrill = "Нострилл"
        static let circular = "Циркуляр"
        static let labret = "Лабрет"
        static let kolco = "Кольцо"
        static let banan = "Банан"
        static let top = "Топ"
    }
    
    struct priceDirecion {
        
        static let defaultState = "—"
        static let increace = "Сначала дешевле"
        static let decrease = "Сначала дороже"
    }
    
    struct Colors {
        
        static let gray: UIColor = UIColor(red: 67/255, green: 67/255, blue: 67/255, alpha: 1.0)
        static let gold: UIColor = UIColor(red: 140/255, green: 102/255, blue: 53/255, alpha: 1.0)
        static let red: UIColor = UIColor(red: 242/255, green: 97/255, blue: 97/255, alpha: 1.0)
    }
    
    struct CornerRadiusTo {
        
        static let viewAndImage: CGFloat = 12
        static let imageInContainer: CGFloat = 4
        static let sheetController: CGFloat = 28
    }
    
    struct Firebase {
        
        static let appointmentsPath = "appointments"
        static let decorationsPath = "decorations"
        static let mastersPath = "masters"
        static let servicesPath = "services"
        static let servicesAdditionalPath = "servicesAdditional"
        static let questionsPath = "popularQuestions"
    }
    
    struct SocialNetworks {
        
        static let telegram = "https://t.me/+"
        static let whatsApp = "https://api.whatsapp.com/send?phone="
        static let instagram = "https://instagram.com/holey.valley.piercing/"
        static let tikTok = "https://vm.tiktok.com/ZMN1XXtLe/"
    }
    
    struct Coordinates {
        
        static let latitude = 53.906117
        static let longitude = 27.520889
    }
}
