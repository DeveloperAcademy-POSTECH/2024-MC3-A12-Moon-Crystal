//
//  OnboardingView.swift
//  MoonCrystal
//
//  Created by zaehorang on 8/1/24.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentStep: OnboardingStep = .first
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentStep) {
                onboardingStepView(step: .first)
                    .tag(OnboardingStep.first)
                
                onboardingStepView(step: .second)
                    .tag(OnboardingStep.second)
                
                onboardingStepView(step: .third)
                    .tag(OnboardingStep.third)
                
            }
            .padding(.top, 100)
            
            Button {
                moveToNextStep()
            } label: {
                RoundedRectangle(cornerRadius: 12)
                    .frame(height: 68)
                    .foregroundStyle(.gray900)
                    .overlay(
                        Text(currentStep.buttonTitle)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(.white))
            }
            .padding(.bottom, 86)
            Spacer()
        }
        .padding(.horizontal)
        .background(.gray50)
        .ignoresSafeArea(.all, edges: [.top, .bottom])
    }
    
    private func moveToNextStep() {
        withAnimation {
            switch currentStep {
            case .first:
                currentStep = .second
            case .second:
                currentStep = .third
            case .third:
                //TODO: 온보딩이 끝난 후의 동작 (예: 메인 화면으로 이동)
                break
            }
        }
    }
}

#Preview {
    OnboardingView()
}
