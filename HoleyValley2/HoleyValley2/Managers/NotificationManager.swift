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
        content.body = body
        content.sound = .defaultCritical
                
        let pushDate = Date(timeIntervalSince1970: time.timeIntervalSince1970)
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month, .day, .year, .hour, .minute], from: pushDate as Date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}
