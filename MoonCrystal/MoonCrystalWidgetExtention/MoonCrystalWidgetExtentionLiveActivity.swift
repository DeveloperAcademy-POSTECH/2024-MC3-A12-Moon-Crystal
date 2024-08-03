//
//  MoonCrystalWidgetExtentionLiveActivity.swift
//  MoonCrystalWidgetExtention
//
//  Created by sungkug_apple_developer_ac on 7/26/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct MoonCrystalWidgetExtentionLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: dynamicCapacityAttributes.self) { context in
            // LockScreen LiveActivity UI
            VStack {
                HStack(alignment: .top, spacing: 10) {
                    //TODO: 여기에 context에서 가져온 값 넣어줘야됌
                    LiveActivitySaveTimeView(freeCapacity: "10GB")
                    Spacer()
                    //TODO: 여기에 context에서 가져온 값 넣어줘야됌
                    CleanUpStatusView(addedFreeCapacity: "10GB", isLockScreen: true)
                    Spacer()
                }
                .padding(.horizontal, 8)
                
                Spacer()
                DynamicIslandButtonsView()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(25)
            .activityBackgroundTint(Color.black)
            .activitySystemActionForegroundColor(Color.black)
            
        } dynamicIsland: { context in
            // Dynamic Island UI
            DynamicIsland {
                //Dynamic Island 확장 시 UI
                DynamicIslandExpandedRegion(.leading) {
                    //TODO: 여기에 context 남은용량을 넣어야됨
                    LiveActivitySaveTimeView(freeCapacity: "10GB")
                        .padding(.top, 5)
                        .padding(.leading, 8)
                }
                
                DynamicIslandExpandedRegion(.trailing) {
                    CleanUpStatusView()
                        .padding(.top, 5)
                        .padding(.trailing, 8)
                }
                
                DynamicIslandExpandedRegion(.bottom, priority: 1) {
                    VStack{
                        DynamicIslandButtonsView(isLoading: context.state.isLoading)
                    }
                    .padding(.horizontal, 8)
                }
                
            } compactLeading: {
                Text("정리중")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.white)
            } compactTrailing: {
                Text("\(context.state.freeCapacity)")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.pink300)
            } minimal: {}
            // TODO: 나중에 다이나믹 아일랜드 클릭시 넘어가는 페이지 설정
                .widgetURL(URL(string: "http://www.apple.com"))
                .keylineTint(Color.white)
        }
    }
}

extension dynamicCapacityAttributes {
    fileprivate static var preview: dynamicCapacityAttributes {
        dynamicCapacityAttributes(name: "World")
    }
}

extension dynamicCapacityAttributes.ContentState {
    fileprivate static var smiley: dynamicCapacityAttributes.ContentState {
        dynamicCapacityAttributes.ContentState(freeCapacity: "5.8GB", cleanUpCapacity: 42)
    }
    
    fileprivate static var starEyes: dynamicCapacityAttributes.ContentState {
        dynamicCapacityAttributes.ContentState(freeCapacity: "🤩", cleanUpCapacity: 42)
    }
}

#Preview("Notification", as: .content, using: dynamicCapacityAttributes.preview) {
    MoonCrystalWidgetExtentionLiveActivity()
} contentStates: {
    dynamicCapacityAttributes.ContentState.smiley
    dynamicCapacityAttributes.ContentState.starEyes
}
