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
        VStack(alignment: .center, spacing: 0) {
            TabView(selection: $currentStep) {
                onboardingStepView(step: .first, stepButtonAction: moveToNextStep)
                    .tag(OnboardingStep.first)
                    .onAppear {
                        Tracking.Screen.onboardingStep1.setTracking()
                    }
                
                onboardingStepView(step: .second, stepButtonAction: moveToNextStep)
                    .tag(OnboardingStep.second)
                    .onAppear {
                        Tracking.Screen.onboardingStep2.setTracking()
                    }
                
                onboardingStepView(step: .third, stepButtonAction: moveToNextStep)
                    .tag(OnboardingStep.third)
                    .onAppear {
                        Tracking.Screen.onboardingStep3.setTracking()
                    }
            }
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

#Preview {
    OnboardingView(isFirstLaunch: .constant(true))
}
