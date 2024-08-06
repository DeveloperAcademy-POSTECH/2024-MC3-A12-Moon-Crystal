//
//  UserProfileCreationPageText.swift
//  MoonCrystal
//
//  Created by zaehorang on 7/30/24.
//

enum UserProfileCreationPage: Int {
    case favoriteIdol = 1
    case nickname
    case idolImage
    
    var title: String {
        switch self {
        case .favoriteIdol:
            return "누구를 위해\n용량을 정리할까요?"
        case .nickname:
            return "어떻게\n불러드릴까요?"
        case .idolImage:
            return "좋아하는 최애 사진을\n업로드 해주세요"
        }
    }
    
    var description: String {
        switch self {
        case .favoriteIdol:
            return "좋아하는 그룹이름 또는 최애를 적어도 좋아요"
        case .nickname:
            return "팬덤 이름 또는 원하는 닉네임을 적어도 좋아요"
        case .idolImage:
            return "홈 화면 프로필 아이콘, 팁에 사용됩니다"
        }
    }
    
    var warningMessage: String {
        switch self {
        case .favoriteIdol:
            return "이름이 너무 길어요. 대신 애칭을 적어주세요."
        case .nickname:
            return "이름이 너무 길어요."
        case .idolImage:
            return ""
        }
    }
}
