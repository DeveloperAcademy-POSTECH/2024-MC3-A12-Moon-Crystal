//
//  JosaFomatter.swift
//  MoonCrystal
//
//  Created by sungkug_apple_developer_ac on 8/8/24.
//

import Foundation

class JosaFomatter {
    static func postPositionText(_ name: String) -> String {
        guard let lastText = name.last else { return name }
        // 유니코드 전환
        let unicodeVal = UnicodeScalar(String(lastText))?.value
        // 한글아니면 반환
        guard let value = unicodeVal else { return name }
        // 종성인지 확인
        if (value < 0xAC00 || value > 0xD7A3) { return name }
        // 받침있으면 을 없으면 를 반환
        let last = (value - 0xAC00) % 28
        
        let str = last > 0 ? "을" : "를"
        return name + str
    }
}
