//
//  Int+Extension.swift
//  MoonCrystal
//
//  Created by seonu kim on 7/29/24.
//

import Foundation

extension Int {
    /// Int+Extensions - 분단위를 시간과 분으로 나눠서 반납하는 extension
    func minutesToHoursAndMinutes() -> (hours: Int, minutes: Int) {
        let hours = self / 60
        let minutes = self % 60
        return (hours: hours, minutes: minutes)
    }
    
    /// Int+Extensions - 바이트를 GB단위로 바꾸는 extension
    func byteToGBStr(format: String = "%.0f") -> String {
        // 1024 바이트 단위로 안나뉘어서 바꿈
        let bytesInGB: Double = 1000 * 1000 * 1000
        let gbValue: Double = Double(Int64(self)) / bytesInGB
        // 값이 0.1보다 작을 때 소수점 안보이게 만듦
        if gbValue < 0.1 {
            return String(format: "%.0f", gbValue)
        }
        return String(format: format, gbValue)
    }
    
    func byteToGB(format: String = "%.0f") -> Double {
        let bytesInGB: Double = 1000 * 1000 * 1000
        let gbValue: Double = Double(self) / bytesInGB
        return gbValue
    }
}
