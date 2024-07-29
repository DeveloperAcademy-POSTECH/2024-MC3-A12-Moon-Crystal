//
//  UserProfile.swift
//  MoonCrystal
//
//  Created by zaehorang on 7/29/24.
//

import Foundation

struct UserProfile: Codable {
    var favoriteIdol: String
    var nickname: String
    var image: Data
    
    // struct를 Data타입으로 인코딩함. 리턴값은 AppStorage에 실제로 저장되는 값.
    func encode() -> Data? {
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(self) {
            return encoded
        } else {
            print("❌ UserProfile/encode")
            return nil
        }
    }
    
    // AppStorage에서 Data값을 가져오면, User 구조체로 다시 변환해 화면에 뿌려줄 수 있음.
    static func decode(userData: Data) -> UserProfile? {
        let decoder = JSONDecoder()
        
        if let user = try? decoder.decode(UserProfile.self, from: userData) {
            return user
        } else {
            print("❌ UserProfile/decode")
            return nil
        }
    }
    
}
