//
//  TipViewModel.swift
//  MoonCrystal
//
//  Created by seonu kim on 9/17/24.
//

import Foundation

class TipViewModel {
    let title = "GB를 확보하려면\n얼마나 삭제해야 할까요?"
    let videoFormatString: String
    let standardGB: Int
    let photoNumber: Int
    let videoTime: Int
    
    init(videoFormat: VideoFormatCapacity) {
        /// 기본화질과 고화질 구분
        let isDefaultQuality = videoFormat == .defaultQuality
        /// Byte 단위로 된 용량
        let capacity = isDefaultQuality ? 5368709120 : 21474836480
        
        videoFormatString = isDefaultQuality ? "기본화질" : "고화질"
        standardGB = isDefaultQuality ? 5 : 20
        
        photoNumber = MediaCapacityConverter.capacityToPhoto(capacity: capacity)
        videoTime = MediaCapacityConverter.capacityToMinute(capacity: capacity, format: videoFormat)
    }
}
