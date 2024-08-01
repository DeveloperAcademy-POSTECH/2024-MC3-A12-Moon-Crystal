//
//  LiveActivityButtonsView.swift
//  MoonCrystal
//
//  Created by sungkug_apple_developer_ac on 8/1/24.
//

import SwiftUI

struct LiveActivityButtonsView: View {
    @State var isLoading = false
    
    var body: some View {
        HStack{
            Button(intent: UpdateTaskAppIntent(), label: {
                Label("Update", image:"")
            })
            .buttonStyle(.plain)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,minHeight:40,maxHeight:40)
            .background(Color.green)
            .clipShape(Capsule())
            .foregroundStyle(Color.white)
            
            if !isLoading {
                Button(intent: CompleteTaskAppIntent(), label: {
                    Label("Complete", image:"")
                })
                .buttonStyle(.plain)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,minHeight:40,maxHeight:40)
                .background(Color.green)
                .clipShape(Capsule())
                .foregroundStyle(Color.white)
            } else {
                RoundedRectangle(cornerRadius: 20, style: .circular)
                    .frame(width: .infinity,height: 40)
                    .foregroundStyle(Color.green)
                    .overlay(content: {
                        ProgressView(timerInterval: Date()...Date(timeIntervalSinceNow: 2), countsDown: false, label: {}, currentValueLabel: {})
                        .frame(width: 26,height: 26)
                        .progressViewStyle(.circular)
                        .foregroundStyle(.white)
                    })
            }
        }
    }
}

#Preview {
    LiveActivityButtonsView()
}
