//
//  CapacityCleanupView.swift
//  MoonCrystal
//
//  Created by zaehorang on 8/1/24.
//

import Lottie
import SwiftUI

struct CapacityCleanupView: View {
    private let lottieFileName = "Timer"
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 60) {
            HStack {
                //TODO: 내부 값 바꾸기
                Text("지금까지 0분(0GB)\n확보했어요")
                    .foregroundStyle(.gray900)
                    .font(.system(size: 28, weight: .semibold))
                    .multilineTextAlignment(.leading)
                    .frame(height: 74)
                Spacer()
            }
            .padding(.top, 60)
            
            VStack(spacing: 38) {
                //TODO: 내부 값 바꾸기
                Text("NCT를 위해 정리중 ...")
                    .foregroundStyle(.gray600)
                    .font(.system(size: 15, weight: .regular))
                
                LottieView(animation: .named(lottieFileName))
                    .playing(loopMode: .loop)
                    .frame(height: 160)
                    .scaledToFill()
            }
            
            VStack(spacing: 82) {
                HStack(spacing: 49) {
                    capacityTextView(title: "현재 남은 용량", value: "1GB")
                    Divider()
                    capacityTextView(title: "촬영 가능 시간", value: "0h 2m")
                }
                .frame(height: 60)
                .padding(.top, 24)
                .padding(.horizontal, 54)
                
                Button {
                    //TODO: 정리 종료 로직 추가하기
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 60)
                        .foregroundStyle(Color.gray900)
                        .overlay(
                            Text("정리 종료하기")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundStyle(.white))
                        .padding(.bottom, 60)
                        .ignoresSafeArea(.all, edges: .bottom)
                }
            }
        }
        .padding(.horizontal)
    }
    
    private func capacityTextView(title: String, value: String) -> some View {
        VStack(spacing: 6) {
            Text(title)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(.gray600)
            Text(value)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.gray900)
        }
    }
}
#Preview {
    CapacityCleanupView()
}
