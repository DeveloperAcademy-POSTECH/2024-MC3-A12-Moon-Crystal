//
//  UpdateTaskAppIntent.swift
//  MoonCrystal
//
//  Created by sungkug_apple_developer_ac on 8/1/24.
//

import ActivityKit
import AppIntents

@available(iOS 17.0, *)
struct UpdateTaskAppIntent: LiveActivityIntent {
    
    static var openAppWhenRun: Bool = false
    static var title: LocalizedStringResource = "UpdatLiveActivityIntent"
    static var isDiscoverable: Bool = false
    
    func perform() async throws -> some IntentResult {
        
        return await withCheckedContinuation{continuation in
            //TODO: 나중에 여기서 현재 용량 조회 로직을 사용할 수 있어야됨
            LiveActivityManager.updateLiveActivity(freeCapacity: "update", cleanUpCapacity: 10)
            continuation.resume(returning: IntentResultContainer.result())
        }
        
    }
}
