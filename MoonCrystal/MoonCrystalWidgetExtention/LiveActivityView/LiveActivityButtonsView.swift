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
        HStack {
            if !isLoading {
                Button(intent: CompleteTaskAppIntent(), label: {
                    Label("종료", image:"")
                })
                .buttonStyle(.plain)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,minHeight:40,maxHeight:40)
                .background(.gray800)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .foregroundStyle(Color.white)
            } else {
                loadingButton
            }
            
            Button(intent: UpdateTaskAppIntent(), label: {
                Label("새로고침", image:"")
            })
            .buttonStyle(.plain)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight:44, maxHeight:44)
            .background(.pink300)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .foregroundStyle(Color.white)
        }
    }
    
    var loadingButton: some View {
        RoundedRectangle(cornerRadius: 12)
            .frame(width: .infinity,height: 40)
            .foregroundStyle(.gray800)
            .overlay(content: {
                ProgressView(timerInterval: Date()...Date(timeIntervalSinceNow: 2), countsDown: false, label: {}, currentValueLabel: {})
                .frame(width: 26,height: 26)
                .progressViewStyle(.circular)
                .foregroundStyle(.white)
            })
    }
}

#Preview {
    LiveActivityButtonsView()
}
