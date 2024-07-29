//
//  ContentView.swift
//  MoonCrystal
//
//  Created by zaehorang on 7/25/24.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        VStack{
            Button {
                LiveActivityManager.startLiveActivity(freeCapacity: "start")
            } label: {
                Text("start")
            }

        }
    }
}

#Preview {
    ContentView()
}
