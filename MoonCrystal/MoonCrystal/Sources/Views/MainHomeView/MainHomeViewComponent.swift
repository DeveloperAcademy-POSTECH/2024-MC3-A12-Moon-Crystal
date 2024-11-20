//
//  MainHomeViewComponent.swift
//  MoonCrystal
//
//  Created by sungkug_apple_developer_ac on 7/31/24.
//
//TODO: 굳이 있어야 하나? 논의!
enum MainHomeViewComponent {
    case deletedStorage
    case availableTime
    case currentCapacity
    case CleanUpButton

    var title: String {
        switch self {
        case .deletedStorage:
            return "최애를 위해 지금까지 지운 용량"
        case .availableTime:
            return " 촬영할 수 있는 시간"
        case .currentCapacity:
            return "현재 저장 용량"
        case .CleanUpButton:
            return "정리 준비하기"
        }
    }
}
