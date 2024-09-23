//
//  MoonCrystalApp.swift
//  MoonCrystal
//
//  Created by zaehorang on 7/25/24.
//

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
        FirebaseApp.configure()
        
        return true
    }
}
