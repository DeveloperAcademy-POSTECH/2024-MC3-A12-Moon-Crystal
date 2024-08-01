//
//  LiveActivityButtonView.swift
//  MoonCrystal
//
//  Created by sungkug_apple_developer_ac on 8/1/24.
//

import SwiftUI

struct LiveActivityButtonView: View {
    var body: some View {
        Button(intent: CompleteTaskAppIntent(), label: {
            Label("Complete", image:"")
        })
        .buttonStyle(.plain)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,minHeight:40,maxHeight:40)
        .background(Color.green)
        .clipShape(Capsule())
        .foregroundStyle(Color.white)
    }
}

#Preview {
    LiveActivityButtonView()
}
