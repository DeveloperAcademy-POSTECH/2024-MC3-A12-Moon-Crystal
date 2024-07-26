//
//  LiveActivityManager.swift
//  MoonCrystal
//
//  Created by sungkug_apple_developer_ac on 7/26/24.
//

import Foundation
import ActivityKit
import Combine

@available(iOS 16.1, *)
class LiveActivityManager{
    /**
     LiveActivity 생성 요청
     */
    static func startLiveActivity(for activityData: dynamicCapacityAttributes, state contentState: dynamicCapacityAttributes.ContentState) -> String{
        do{
            if #available(iOS 16.2, *) {
                
                let content = ActivityContent(state: contentState, staleDate: Date(timeIntervalSinceNow: 10))
                let activity =  try Activity<dynamicCapacityAttributes>.request(attributes: activityData, content: content)
                
                return activity.id
            } else {
                let activity = try Activity<dynamicCapacityAttributes>.request(attributes: activityData, contentState: contentState)
                return activity.id
                
            }
        }catch{
            print("❌ LiveActivityManager/startLiveActivity LiveActivity start error:\(error)")
            return ""
        }
    }
    
    static func updateLiveActivity(for id: String, contentState state: dynamicCapacityAttributes.ContentState){
        guard let activity = getLiveActivity(for: id) else{
            return
        }
        if #available(iOS 16.2, *) {
            let content = ActivityContent(state: state, staleDate: Date(timeIntervalSinceNow: 10))
            Task{
                await  activity.update(content)
            }
        } else  {
            Task{
                await  activity.update(using: state)
            }
        }
    }
    
    static func getLiveActivity(for id: String) -> Activity<dynamicCapacityAttributes>?{
        Activity<dynamicCapacityAttributes>.activities.first(where: {(activity: Activity<dynamicCapacityAttributes>) in
            activity.id == id
        })
    }

    static func endLiveActvity(for id: String,contentState state: dynamicCapacityAttributes.ContentState? = nil, dismissalPolicy: ActivityUIDismissalPolicy = .immediate){
        guard let activity = getLiveActivity(for: id) else{
            return
        }
        Task{
            if #available(iOS 16.2, *),let state {
                //3분만 보관
                let content = ActivityContent(state: state, staleDate: Date(timeIntervalSinceNow: 60 * 3),relevanceScore: activity.content.relevanceScore)
                await  activity.end(content,dismissalPolicy:dismissalPolicy)
            }else{
                await activity.end(using:state,dismissalPolicy: dismissalPolicy)
            }
        }
    }
    
    
}
