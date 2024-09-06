//
//  DynamicIslandButtonsView.swift
//  MoonCrystal
//
//  Created by sungkug_apple_developer_ac on 8/1/24.
//

import SwiftUI

struct DynamicIslandButtonsView: View {
    @State var isLoading = false
    
    var body: some View {
        HStack {
            if !isLoading {
                Button(intent: CompleteTaskAppIntent(), label: {
                    Text("종료")
                        .font(.system(size: 14, weight: .regular))
                })
                .buttonStyle(.plain)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 44, maxHeight: 44)
                .background(.gray800)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .foregroundStyle(Color.white)
            } else {
                loadingButton
            }
            
            Button(intent: UpdateTaskAppIntent(), label: {
                Text("업데이트")
                    .font(.system(size: 14, weight: .regular))
            })
            .buttonStyle(.plain)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 44, maxHeight: 44)
            .background(.pink300)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .foregroundStyle(Color.white)
        }
    }
    
    var loadingButton: some View {
        RoundedRectangle(cornerRadius: 16)
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
