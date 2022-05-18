//
//  Conctants.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 19.05.22.
//

import Foundation

struct Const {
    static let appName = "HoleyValley"
    static let defaultImage = "https://firebasestorage.googleapis.com/v0/b/holeyvalleytest.appspot.com/o/decorations%2FdefaultImage.png?alt=media&token=dd3b9287-3524-4e9f-a35f-7ba48e30bd41"
    
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
