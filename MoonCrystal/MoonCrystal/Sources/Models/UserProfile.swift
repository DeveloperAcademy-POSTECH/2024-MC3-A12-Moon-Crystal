//
//  UserProfile.swift
//  MoonCrystal
//
//  Created by zaehorang on 7/29/24.
//

import Foundation
import SwiftData

@Model
final class UserProfile {
    var favoriteIdol: String
    var nickname: String
    var image: Data
    
    init(favoriteIdol: String, nickname: String, image: Data) {
        self.favoriteIdol = favoriteIdol
        self.nickname = nickname
        self.image = image
    }
}
