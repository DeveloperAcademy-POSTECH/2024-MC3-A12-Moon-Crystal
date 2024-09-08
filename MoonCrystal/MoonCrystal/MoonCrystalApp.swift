//
//  MoonCrystalApp.swift
//  MoonCrystal
//
//  Created by zaehorang on 7/25/24.
//

import SwiftData
import SwiftUI

@main
struct MoonCrystalApp: App {
    
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
