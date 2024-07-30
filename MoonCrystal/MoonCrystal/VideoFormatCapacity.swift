//
//  VideoFormatCapacity.swift
//  MoonCrystal
//
//  Created by seonu kim on 7/29/24.
//

/// 비디오 포멧별 1분당  데이터를 byte단위로 정리한 enum입니다.
enum VideoFormatCapacity: Int, CaseIterable {
    case uhd4k60fps = 461_373_440
    case uhd4k30fps = 199_229_440
    case hd1080p60fps = 104_857_600
    case defaultQuality = 68_157_440
    
    var detailInfo: String {
        switch self {
        case .uhd4k60fps: return "4K - 60fps"
        case .uhd4k30fps: return "4K - 24fps"
        case .hd1080p60fps: return "1080p HD - 60fps"
        case .defaultQuality: return "1080p HD - 30fps"
        }
    }
}
