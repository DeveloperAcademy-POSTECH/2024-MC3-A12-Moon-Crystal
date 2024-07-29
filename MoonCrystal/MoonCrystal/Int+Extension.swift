//
//  IntExtensions.swift
//  MoonCrystal
//
//  Created by seonu kim on 7/29/24.
//

import Foundation


extension Int {
    ///Int + Extensions -
    ///분단위를 시간과 분으로 나눠서 반납하는 extension
    func minuteToWholeTime() -> (hours : Int, minutes : Int) {
        let hours = self / 60
        let minutes = self % 60
        return (hours : hours, minutes : minutes)
    }
    
    ///Int+Extensions -
    ///바이트를 GB단위로 바꾸는 extension
    func byteToGB() -> String {
        let formatter:ByteCountFormatter = ByteCountFormatter()
        formatter.countStyle = .file
        
        return formatter.string(fromByteCount: Int64(self))
    }
}
