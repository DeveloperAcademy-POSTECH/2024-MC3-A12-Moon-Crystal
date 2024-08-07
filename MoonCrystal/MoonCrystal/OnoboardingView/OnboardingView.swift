//
//  OnboardingView.swift
//  MoonCrystal
//
//  Created by zaehorang on 8/1/24.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var isFirstLaunch: Bool
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
        .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .global)
                            .onEnded { value in
                                let horizontalAmount = value.translation.width
                                if horizontalAmount < 0 && currentStep != .third {
                                    moveToNextStep()
                                } else if horizontalAmount > 0 && currentStep != .first {
                                    moveToBackStep()
                                }
                            })
    }
    
    private func moveToNextStep() {
        withAnimation {
            switch currentStep {
            case .first:
                currentStep = .second
            case .second:
                currentStep = .third
            case .third:
                isFirstLaunch = false
            }
        }
    }
    
    private func moveToBackStep() {
        withAnimation {
            switch currentStep {
            case .first:
                break
            case .second:
                currentStep = .first
            case .third:
                currentStep = .second
            }
        }
    }
}
