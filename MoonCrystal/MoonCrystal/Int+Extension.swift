//
//  IntExtensions.swift
//  MoonCrystal
//
//  Created by seonu kim on 7/29/24.
//

import Foundation


extension Int {
    ///IntExtensions
    /// 분단위를 시간과 분으로 나눠서 반납하는 Int extension
    func minuteToWholeTime() -> (hours : Int, minutes : Int) {
        let hours = self / 60
        let minutes = self % 60
        return (hours : hours, minutes : minutes)
    }
    
}
