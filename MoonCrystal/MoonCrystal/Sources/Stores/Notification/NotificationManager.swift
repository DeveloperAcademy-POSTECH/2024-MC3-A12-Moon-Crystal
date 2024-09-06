//
//  NotificationManager.swift
//  MoonCrystal
//
//  Created by zaehorang on 7/26/24.
//

import Foundation
import NotificationCenter

@MainActor
class NotificationManager: NSObject, ObservableObject {
    private let notificationCenter = UNUserNotificationCenter.current()
    @Published var isGranted = false
    @Published var didTapResultNotification = false
    
    override init() {
        super.init()
        notificationCenter.delegate = self
    }
    
    /// Notification 권한 요청 함수
    func requestAuthorization() async {
        do {
            try await notificationCenter
                .requestAuthorization(options: [.sound, .badge, .alert])
        } catch {
            print("❌ NotificationManager/requestAuthorization: \(error.localizedDescription)")
        }
        
        await getCurrentSettings()
    }
    
    /// 현재 Notification 권한 설정을 가져오는 함수
    func getCurrentSettings() async {
        let currentSettings = await notificationCenter.notificationSettings()
        isGranted = (currentSettings.authorizationStatus == .authorized)
    }
    
    /// Notification 권한 거부 시, 사용자에게 앱 설정 화면을 열도록 안내하는 함수
    func openSettings() {
        //TODO: 해당 메소드를 분리하고 requestNotification class를 삭제하자.
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    /// 주어진 LocalNotification을 스케줄링하는 함수
    /// - Parameter localNotification: 스케줄링할 로컬 알림의 정보가 담긴 LocalNotification 구조체
    func schedule(localNotification: LocalNotification) async {
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
    
    /// 요청한 Noticifation을 모두 지우는 함수
    func clearRequests() {
        notificationCenter.removeAllPendingNotificationRequests()
    }
}

//MARK: - Ex_UNUserNotificationCenterDelegate
extension NotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        guard let notificationType = NotificationType(rawValue: response.notification.request.identifier) else {
            print("❌ NotificationManager/userNotificationCenter")
            return
        }
        
        switch notificationType {
        case .refresh:
            didTapResultNotification = false
        case .result:
            didTapResultNotification = true
        }
    }
}
