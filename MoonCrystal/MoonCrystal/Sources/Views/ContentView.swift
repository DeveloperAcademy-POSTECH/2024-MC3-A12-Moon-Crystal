//
//  ContentView.swift
//  MoonCrystal
//
//  Created by zaehorang on 7/25/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @AppStorage(UserDefaultsKeys.isFirst.rawValue) var isFirstLaunch: Bool = true

    var body: some View {
        if isFirstLaunch {
            OnboardingView(isFirstLaunch: $isFirstLaunch)
        } else {
            MainHomeView()
        }
    }
}

#Preview {
    ContentView()
}
