//
//  MoonCrystalApp.swift
//  MoonCrystal
//
//  Created by zaehorang on 7/25/24.
//

import AdSupport
import AppTrackingTransparency
import FirebaseCore
import SwiftData
import SwiftUI

@main
struct MoonCrystalApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    /// 스플래시 뷰 설정을 위한 시간지연
    init() {
        Thread.sleep(forTimeInterval: 0.5)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: UserProfile.self)
    }
}

//MARK: - AppDelegate class
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Firebase 초기화
        FirebaseApp.configure()
        
        // 앱 추적 권한 요청을 비동기적으로 처리
        Task {
            await requestTrackingAuthorization()
        }
        return true
    }
    
    /// 비동기 추적 권한 요청 함수
    private func requestTrackingAuthorization() async {
        // 1초 지연 후 추적 권한 요청
        do {
            try await Task.sleep(nanoseconds: 500_000_000) // 0.5초 = 500,000,000 나노초
        } catch {
            print(error)
        }
        
        if ATTrackingManager.trackingAuthorizationStatus == .notDetermined {
            let _ = await ATTrackingManager.requestTrackingAuthorization()
        }
    }
}
