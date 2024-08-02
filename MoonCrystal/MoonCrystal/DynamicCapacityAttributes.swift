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
        var capacity: String
        var cleanUpCapacity: Int
        var isLoading = false
        var isCompleted = false
    }
    
    var name: String
}
