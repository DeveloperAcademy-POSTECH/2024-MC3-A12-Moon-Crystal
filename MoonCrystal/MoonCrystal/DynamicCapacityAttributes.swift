//
//  DynamicCapacityAttributes.swift
//  MoonCrystal
//
//  Created by sungkug_apple_developer_ac on 7/26/24.
//

import Foundation
import ActivityKit
import WidgetKit

struct dynamicCapacityAttributes: ActivityAttributes {
    
    public struct ContentState: Codable, Hashable {
        var freeCapacity: Int
        var cleanUpCapacity: Int
        var isLoading = false
        var isCompleted = false
        var videoFormatRaw = VideoFormatCapacity.defaultQuality.rawValue
        var favoritIdol = "최애"
    }
    
    var name: String
}
