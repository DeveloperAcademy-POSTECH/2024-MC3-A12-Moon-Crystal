//
//  DeleteGoalTip.swift
//  MoonCrystal
//
//  Created by seonu kim on 9/17/24.
//

/// TipView에 활용되는 삭제 용량 목표
struct DeleteGoalTip {
    let videoFormatString: String
    let standardGB: Int
    /// Byte 단위로 된 용량
    let standardByte: Int
    
    init(videoFormat: VideoFormatCapacity) {
        /// 기본화질과 고화질 구분
        let isDefaultQuality = videoFormat == .defaultQuality
        videoFormatString = isDefaultQuality ? "기본화질" : "고화질"
        standardGB = isDefaultQuality ? 5 : 20
        standardByte = isDefaultQuality ? 5368709120 : 21474836480
    }
}
