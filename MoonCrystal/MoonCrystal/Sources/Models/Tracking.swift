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
    
    enum Event: String {
        case defaultQualityButtonTapped = "C1_defaultQuality_buttonTapped"
        case hd1080p60fpsButtonTapped = "C1_hd1080p60fps_buttonTapped"
        case uhd4k24fpsButtonTapped = "C1_uhd4k24fps_buttonTapped"
        case uhd4k30fpsButtonTapped = "C1_uhd4k30fps_buttonTapped"
        case uhd4k60fpsButtonTapped = "C1_uhd4k60fps_buttonTapped"
        
        case appBackground = "D1_AppBackground"
        
        //TODO: UpdateTaskAppIntent 구조체에 트래킹 추가하기
        case dynamicIslandUpdateButtonTapped = "E1_DynamicIslandUpdateButtonTapped"
        
        func setTracking() {
            Analytics.logEvent(self.rawValue,
                               parameters: nil)
        }
    }
    
    // VideoFormatCapacity와 트래킹 이벤트 매핑
    static func setFormatButtonTracking(for format: VideoFormatCapacity) {
        switch format {
        case .defaultQuality:
            Event.defaultQualityButtonTapped.setTracking()
        case .hd1080p60fps:
            Event.hd1080p60fpsButtonTapped.setTracking()
        case .uhd4k24fps:
            Event.uhd4k24fpsButtonTapped.setTracking()
        case .uhd4k30fps:
            Event.uhd4k30fpsButtonTapped.setTracking()
        case .uhd4k60fps:
            Event.uhd4k60fpsButtonTapped.setTracking()
        }
    }
}
