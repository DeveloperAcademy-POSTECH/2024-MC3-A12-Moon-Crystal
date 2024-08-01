//
//  ContentView.swift
//  MoonCrystal
//
//  Created by zaehorang on 7/25/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {    
    var body: some View {
        NavigationStack {
            NavigationLink {
                CapacityCleanupView()
            } label: {
                Text("dd")
            }

        }
    }
}

#Preview {
    ContentView()
}
