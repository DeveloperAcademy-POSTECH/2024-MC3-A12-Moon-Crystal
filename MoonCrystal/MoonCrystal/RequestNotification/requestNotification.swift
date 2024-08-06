//
//  requestNotification.swift
//  MoonCrystal
//
//  Created by sungkug_apple_developer_ac on 8/6/24.
//

import Foundation
import NotificationCenter

class requestNotification {
    static func schedule(localNotification: LocalNotification) async {
        let notificationCenter = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = localNotification.title
        content.body = localNotification.body
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: localNotification.timeInterval, repeats: localNotification.repeats)
        let request = UNNotificationRequest(identifier: localNotification.identifier, content: content, trigger: trigger)
        
        do {
            try await notificationCenter.add(request)
        } catch {
            print("❌ NotificationManager/schedule: \(error.localizedDescription)")
        }
    }
}
