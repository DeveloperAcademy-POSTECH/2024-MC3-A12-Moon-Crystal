//
//  onboardingStepView.swift
//  MoonCrystal
//
//  Created by zaehorang on 8/1/24.
//

import Lottie
import SwiftUI

struct onboardingStepView: View {
    let step: OnboardingStep
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text(step.title)
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundStyle(.gray900)
                    Spacer()
                }
                
                HStack {
                    Text(step.description)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(.gray600)
                    Spacer()
                }
            }
            
            LottieView(animation: .named(step.imageName))
                .playing(loopMode: .loop)
                .padding(.horizontal, 30)
                .padding(.top, 50)
                .frame(height: 300)
                .scaledToFit()
            
            // 페이지 인디케이터
            HStack(spacing: 14) {
                ForEach(0..<3) { index in
                    Circle()
                        .fill(index == step.rawValue ? .gray700 : .gray300)
                        .frame(width: 8)
                }
            }
            .padding(.top, 57)
            Spacer()
        }
        .background(.gray50)
    }
}

#Preview {
    onboardingStepView(step: .second)
}
