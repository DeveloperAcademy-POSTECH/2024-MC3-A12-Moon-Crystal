//
//  CompleteTaskAppIntent.swift
//  MoonCrystal
//
//  Created by sungkug_apple_developer_ac on 8/1/24.
//

import AppIntents
import ActivityKit

@available(iOS 17.0, *)
struct CompleteTaskAppIntent: LiveActivityIntent {

    static var openAppWhenRun: Bool = false
    static var title: LocalizedStringResource = "CompleteTaskLiveActivityIntent"
    static var isDiscoverable: Bool = false
    
    func perform() async throws -> some IntentResult {
        
        await LiveActivityManager.showLoadingButton()
        sleep(2)
        return await withCheckedContinuation{continuation in
            LiveActivityManager.endLiveActivity()
            continuation.resume(returning: IntentResultContainer.result())
        }
        
    }
}
