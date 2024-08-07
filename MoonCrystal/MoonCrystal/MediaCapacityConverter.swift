//
//  MediaCapacityConverter.swift
//  MoonCrystal
//
//  Created by seonu kim on 7/27/24.
//

/// 남은 잔여 용량을 비디오 촬영시간 또는 촬영 가능 사진 수로 반환하는 함수들의 class입니다.
class MediaCapacityConverter {
    static func capacityToMinute(capacity: Int, format: VideoFormatCapacity) -> Int {
        return capacity / format.rawValue
    }
    
    static func capacityToHourAndMinute(capacity: Int, format: VideoFormatCapacity) -> String {
        let minute = capacity / format.rawValue
        switch minute {
        case 0..<60 : return "\(minute)분"
        case let x where x % 60 == 0 : return "\(x / 60)시간"
        default: return "\(minute / 60)시간 \(minute % 60)분"
        }
    }
    
    static func capacityToPhoto(capacity: Int) -> Int {
        return capacity / 3_145_728
    }
    
    static func getavailableTimeText(capacity: Int, format: VideoFormatCapacity) -> String{
        let availableTime = capacityToMinute(capacity: capacity, format: format)
        var availableTimeText = ""
        
        availableTimeText += String(availableTime.minutesToHoursAndMinutes().hours)
        availableTimeText += "h "
        availableTimeText += String(availableTime.minutesToHoursAndMinutes().minutes)
        availableTimeText += "m"

        return availableTimeText
    }
}
