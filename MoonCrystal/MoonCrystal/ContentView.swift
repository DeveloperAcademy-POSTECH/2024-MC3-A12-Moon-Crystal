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
//        MainHomeView()
        Button(action: {
            LiveActivityManager.startLiveActivity(freeCapacity: "start")
        }, label: {
            /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
        })
    }
}

#Preview {
    ContentView()
}
