//
//  CapacityToTime.swift
//  MoonCrystal
//
//  Created by seonu kim on 7/27/24.
//

import Foundation
 
/// 남은 잔여 용량을 비디오 촬영시간 또는 촬영 가능 사진 수로 반환하는 함수들의 class입니다.
class MediaCapacityConverter {
    static func capacityToTime(capacity: Int, format: VideoFormatCapacity) -> Int {
        return capacity / format.rawValue
    }
    
    static func capacityToPhoto(capacity: Int) -> Int {
        return capacity / 3_145_728
    }
}
