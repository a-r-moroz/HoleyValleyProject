//
//  NotificationManager.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 13.06.22.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    class func requestAutorization(body: String, time: Date) {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Success")
                setNotification(body: body, time: time)
            } else {
                print("Error")
            }
        }
    }
    
    class func setNotification(body: String, time: Date) {
        
        let content = UNMutableNotificationContent()
        content.title = "HoleyValley"
//        content.subtitle = ""
        content.body = body
        content.sound = .defaultCritical
                
//        let pushDate = time
        let pushDate = Date(timeIntervalSince1970: time.timeIntervalSince1970)
//        let pushDate = Date(timeIntervalSince1970: time.timeIntervalSince1970 - (60 * 60))
//        let pushDate = Date(timeIntervalSince1970: time.timeIntervalSince1970 - (15 * 60))
        // UserDefaults.standard.string(forKey: "userName")

        let calendar = Calendar.current
        let components = calendar.dateComponents([.month, .day, .year, .hour, .minute], from: pushDate as Date)
                
        // по дате нужно создать дэйт компоненты (above ↑)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        // реквест для размещения уведомления в центре уведомлений
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
//    class func requestDefaultAutorization() {
//
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
//            if success {
//                setDefaultNotification()
//            } else {
//                print("Error")
//            }
//        }
//    }
//
//    class func setDefaultNotification() {
//
//        let content = UNMutableNotificationContent()
//        content.title = "Внимание!"
//        content.body = "Это специальное напоминание, которое должно придти в понедельник 18.04.2022 в 19:30"
//        content.sound = .defaultCritical
//
//        var dateComponents = DateComponents()
//        dateComponents.day = 14
//        dateComponents.hour = 15
//        dateComponents.minute = 28
//
//        let defaultTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
//
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: defaultTrigger)
//
//        UNUserNotificationCenter.current().add(request)
//    }
}
