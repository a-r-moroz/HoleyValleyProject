//
//  SettingsPoints.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 12.06.22.
//

import Foundation
import UIKit

enum SettingsPoints: CaseIterable {
    
    case notifications
    
    var settingTitle: String {
        switch self {
        case .notifications:
            return "Напоминания по времени"
        }
    }
}

enum SettingsSections: CaseIterable {
    
    case notificationsSection
    
    var sectionTitle: String {
        switch self {
        case .notificationsSection:
            return "Настройки напоминаний"
        }
    }
    
    var sectionImage: UIImage? {
        switch self {
        case .notificationsSection:
            return UIImage(systemName: "bell")
        }
    }
}
