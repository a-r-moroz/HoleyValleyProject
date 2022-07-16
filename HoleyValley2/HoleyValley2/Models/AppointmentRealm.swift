//
//  AppointmentRealm.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 11.07.22.
//

import Foundation
import RealmSwift

class AppointmentRealm: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var phone: String = ""
    @objc dynamic var date: Date = .now
    @objc dynamic var time: String = ""
    @objc dynamic var masterName: String = ""
    @objc dynamic var notificationDateAndTime: String = ""
    
    convenience init(name: String = "", phone: String = "", date: Date = .now, time: String = "", masterName: String = "", notificationDateAndTime: String = "") {
        
        self.init()
        self.name = name
        self.phone = phone
        self.date = date
        self.time = time
        self.masterName = masterName
        self.notificationDateAndTime = notificationDateAndTime
    }
}
