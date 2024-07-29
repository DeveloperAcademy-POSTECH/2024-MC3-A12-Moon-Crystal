//
//  CapacityToTime.swift
//  MoonCrystal
//
//  Created by seonu kim on 7/27/24.
//
import Foundation

/// MediaCapacityConverter/VideoFormatCapacity
/// 비디오 포멧별 1분당  데이터를 byte단위로 정리한 enum입니다.
enum VideoFormatCapacity : Int {
    case uhd4k60fps = 461_373_440
    case uhd4k30fps = 199_229_440
    case hd1080p60fps = 104_857_600
    case defaultQuality = 68_157_440
    
    var detailInfo : String {
        switch self {
        case .uhd4k60fps : return "4K 60fps"
        case .uhd4k30fps : return "4K 30fps"
        case .hd1080p60fps : return "1080p 30fps"
        case .defaultQuality : return "HD 30fps"
        }
    }
}

///MeddiaCapacityConverter/PhotoFormatCapacity
///사진 포멧별 1장당 데이터를 byte 단위로 정리한 enum입니다.
enum PhotoFormatCapacity : Int {
    case highQuality = 78_643_200
    case defaultQuality = 3_145_728
    
    var detailInfo : String {
        switch self {
        case .highQuality : return "ProRAW 48MP"
        case .defaultQuality : return "HEIF 24MP"
        }
    }
}

/// MediaCapacityConverter/MediaCapacityConverter
/// 남은 잔여 용량을 비디오 촬영시간 또는 촬영 가능 사진 수로 반환하는 함수들의 class입니다.
class MediaCapacityConverter {
    //만약 데이터를 저장한다면 남은 용량 객체도 어디선가 계속 끊임없이 받아오는 객체일 듯함
    //다른 객체에 통합시키는 게 낫지 않을까?
    
    ///바이트단위의 남은 용량과 비디오 포맷을 입력받아 해당 포맷의 비디오 촬영 가능 시간을 반환하는 함수입니다.
    static func CapacityToTime(capacity : Int, format : VideoFormatCapacity) -> Int {
        return capacity / format.rawValue
    }
    
    ///바이트단위의 남은 용량과 사진 포맷을 입력받아 해당 포맷으로 촬영 가능한 사진의 갯수를 반환합니다.
    static func CapacityToPhoto(capacity : Int, format : PhotoFormatCapacity) -> Int {
        return capacity / format.rawValue
    }
}

/// 분단위를 시간과 분으로 나눠서 반납하는 Int extension
extension Int {
    func minuteToWholeTime() -> (hours : Int, minutes : Int) {
        let hours = self / 60
        let minutes = self % 60
        return (hours : hours, minutes : minutes)
    }
}
