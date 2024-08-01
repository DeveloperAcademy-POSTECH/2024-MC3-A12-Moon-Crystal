//
//  UpdateTaskAppIntent.swift
//  MoonCrystal
//
//  Created by sungkug_apple_developer_ac on 8/1/24.
//

import ActivityKit
import AppIntents

@available(iOS 17.0, *)
struct UpdateTaskAppIntent:LiveActivityIntent {
    
    static var openAppWhenRun: Bool = false
    static var title: LocalizedStringResource = "Live activity"
    static var isDiscoverable: Bool = false
    
    func perform() async throws -> some IntentResult {
        
        return await withCheckedContinuation{continuation in
            LiveActivityManager.updateLiveActivity(freeCapacity: "update")
            continuation.resume(returning: IntentResultContainer.result())
        }
        
    }
}
