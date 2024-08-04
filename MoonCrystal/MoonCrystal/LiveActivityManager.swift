//
//  LiveActivityManager.swift
//  MoonCrystal
//
//  Created by sungkug_apple_developer_ac on 7/26/24.
//

import ActivityKit
import Foundation

@available(iOS 16.1, *)
class LiveActivityManager {
    
    // LiveActivity 생성 요청
    static func startLiveActivity() async {
        do {
            let freeCapacity = await CapacityCalculator.getFreeCapacity()
            let cleanUpCapacity = await CapacityCalculator.getCleanUpFreeCapacity()
            let videoFormat = UserDefaults.standard.integer(forKey: UserDefaultsKeys.seletedVideoFormat.rawValue)
            let activityData = dynamicCapacityAttributes(name: "RemainingCapacity")
            let contentState = dynamicCapacityAttributes.ContentState(freeCapacity: freeCapacity, cleanUpCapacity: cleanUpCapacity, videoFormatRaw: videoFormat)
            
            if #available(iOS 16.2, *) {
                if ActivityAuthorizationInfo().areActivitiesEnabled {
                    
                    let content = ActivityContent(state: contentState, staleDate:  Date(timeIntervalSinceNow: 10))
                    let _ = try Activity<dynamicCapacityAttributes>.request(attributes:  activityData, content: content)
                }
            } else {

                let _ = try Activity<dynamicCapacityAttributes>.request(attributes:  activityData, contentState: contentState)
            }
        } catch {
            print("❌ LiveActivityManager/startLiveActivity LiveActivity start error:\(error)")
        }
    }
    
    // LiveActivity 업데이트
    static func updateLiveActivity() async {
        
        guard let activity = getLiveActivity(name: "RemainingCapacity") else {
            print("❌ LiveActivityManager/updateLiveActivity Not found Activity")
            return
        }
        let freeCapacity = await CapacityCalculator.getFreeCapacity()
        let cleanUpCapacity = await CapacityCalculator.getCleanUpFreeCapacity()
        let updatedContent = dynamicCapacityAttributes.ContentState(freeCapacity:  freeCapacity, cleanUpCapacity: cleanUpCapacity, videoFormatRaw: activity.content.state.videoFormatRaw)
        if #available(iOS 16.2, *) {
            
            let content = ActivityContent(state: updatedContent, staleDate:  Date(timeIntervalSinceNow: 10))
            
            Task{
                await  activity.update(content)
            }
            
        } else {
            
            Task{
                await  activity.update(using: updatedContent)
            }
            
        }
    }
    
    static func getLiveActivity(name: String) -> Activity<dynamicCapacityAttributes>? {
        Activity<dynamicCapacityAttributes>.activities.first(where: {$0.attributes.name == name})
    }
    
    // LiveActivity 종료버튼 클릭 후 로딩
    static func showLoadingButton() async {
        guard let activity = getLiveActivity(name: "RemainingCapacity") else {
            print("❌ LiveActivityManager/showLoadingButton Not found Activity")
            return
        }

        let updatedContent = dynamicCapacityAttributes.ContentState(freeCapacity: activity.content.state.freeCapacity, cleanUpCapacity: 0, isLoading: true, videoFormatRaw: activity.content.state.videoFormatRaw)
        let content = ActivityContent(state: updatedContent, staleDate:  Date(timeIntervalSinceNow: 10))
        
        Task{
            await activity.update(content)
        }
    }
    
    // LiveActivity 종료
    static func endLiveActivity(contentState state: dynamicCapacityAttributes.ContentState? = nil, dismissalPolicy: ActivityUIDismissalPolicy = .immediate) {
        guard let activity = getLiveActivity(name: "RemainingCapacity") else {
            print("❌ LiveActivityManager/endLiveActivity Not found Activity")
            return
        }
        Task{
            if #available(iOS 16.2, *), let state {
                //3분만 보관
                let content = ActivityContent(state: state, staleDate: Date(timeIntervalSinceNow: 60 * 3), relevanceScore: activity.content.relevanceScore)
                await activity.end(content,dismissalPolicy:dismissalPolicy)
            } else {
                await activity.end(using:state, dismissalPolicy: dismissalPolicy)
            }
            // 종료 후 정리된 용량 총 정리 데이터에 더함
            var deletedTotalCapacity = UserDefaults.standard.integer(forKey: UserDefaultsKeys.deletedTotalCapacity.rawValue)
            var cleanUpCapacity = await CapacityCalculator.getCleanUpFreeCapacity()
            deletedTotalCapacity += cleanUpCapacity
            UserDefaults.standard.set(deletedTotalCapacity, forKey: UserDefaultsKeys.deletedTotalCapacity.rawValue)
        }
    }
    
    static func isLiveActivityActive() -> Bool {
        guard let activity = getLiveActivity(name: "RemainingCapacity") else {
            return false
        }
        
        return activity.activityState == .active
    }
}
