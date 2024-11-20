//
//  requestNotification.swift
//  MoonCrystal
//
//  Created by sungkug_apple_developer_ac on 8/6/24.
//

import Foundation
import NotificationCenter

// wigetExtention에서 충돌나는 부분(openSettings)이 있어 따로 빼둠
//TODO: class명 수정 필요
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
