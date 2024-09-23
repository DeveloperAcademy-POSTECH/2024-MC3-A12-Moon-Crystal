//
//  Tracking.swift
//  MoonCrystal
//
//  Created by zaehorang on 9/23/24.
//

import FirebaseAnalytics

enum Tracking {
    enum Screen: String {
        case onboardingStep1 = "A1_OnboardingStep1"
        case onboardingStep2 = "A1_OnboardingStep2"
        case onboardingStep3 = "A1_OnboardingStep3"
        
        case mainHome = "B1_MainHome"
        case profileCreation = "B2_UserProfileCreation"
        case profileDetail = "B2_ProfileDetail"
        case deletedTotalCapacity = "B3_DeletedTotalCapacity"
        
        case formatInput = "C1_FormatInput"
        case capacitySetting = "C2_CapacitySetting"
        case capacityDirectInput = "C2_CapacityDirectInput"
        case deleteTip = "C3_DeleteTip"
        
        case preCleanupInfo = "D1_PreCleanupInfo"
        case capacityCleanup = "D2_CapacityCleanup"
        case endCleanUp = "D3_EndCleanUp"
        
        // setTracking 메서드 추가
        func setTracking() {
            Analytics.logEvent(AnalyticsEventScreenView,
                               parameters: [
                                AnalyticsParameterScreenName: self.rawValue
                               ])
        }
    }
}
