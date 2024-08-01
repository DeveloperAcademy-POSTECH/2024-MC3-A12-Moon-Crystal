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
    
    var body: some Scene {
        WindowGroup {
            ContentView()

        }
        .modelContainer(for: UserProfile.self)
    }
}
