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
        content.title = "Напоминание"
        content.subtitle = "Этот день настал!"
        content.body = body
        content.sound = .defaultCritical
                
        let pushDate = Date(timeIntervalSince1970: time.timeIntervalSince1970 - (60 * 60))
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
}
