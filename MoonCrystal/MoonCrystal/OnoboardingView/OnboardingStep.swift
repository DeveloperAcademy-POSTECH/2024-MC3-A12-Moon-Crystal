//
//  OnboardingStep.swift
//  MoonCrystal
//
//  Created by zaehorang on 8/1/24.
//

enum OnboardingStep: Int, CaseIterable {
    case first = 0
    case second
    case third

    var imageName: String {
        switch self {
        case .first:
            return "Onboarding1" // 첫 번째 화면의 이미지 이름
        case .second:
            return "Onboarding2" // 두 번째 화면의 이미지 이름
        case .third:
            return "Onboarding3" // 세 번째 화면의 이미지 이름
        }
    }

    var title: String {
        switch self {
        case .first:
            return "최애를 충분히 찍을 수 있다는\n확신을 가져보세요"
        case .second:
            return "얼마나 정리해야할지\n가늠하기 쉽게 알려드려요"
        case .third:
            return "실시간으로\n정리를 도와줄게요"
        }
    }
    
    var description: String {
        switch self {
        case .first:
            return "얼마나 촬영할 수 있는지 알려줄게요"
        case .second:
            return "가이드를 통해 얼마나 정리할지 감을 잡아봐요"
        case .third:
            return "얼마나 정리했는지 빠르게 확인할 수 있어요"
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .first:
            return "계속"
        case .second:
            return "계속"
        case .third:
            return "완료하기"
        }
    }
}
