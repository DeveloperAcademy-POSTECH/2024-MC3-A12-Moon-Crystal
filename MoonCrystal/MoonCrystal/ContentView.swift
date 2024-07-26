//
//  ContentView.swift
//  MoonCrystal
//
//  Created by zaehorang on 7/25/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CapacityManager.shared

    var body: some View {
        MainView()
    }
}

#Preview {
    ContentView()
}
