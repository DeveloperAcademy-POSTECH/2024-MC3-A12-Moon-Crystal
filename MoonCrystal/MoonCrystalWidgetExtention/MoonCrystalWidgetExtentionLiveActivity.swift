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
                    LiveActivitySaveTimeView(freeCapacity: context.state.freeCapacity,
                                             seletedVideoFormat: VideoFormatCapacity(rawValue: context.state.videoFormatRaw) ?? .defaultQuality)
                    Spacer()
                    CleanUpStatusView(cleanUpCapacity: context.state.cleanUpCapacity,
                                      seletedVideoFormat: VideoFormatCapacity(rawValue: context.state.videoFormatRaw)
                                      ?? .defaultQuality,  isLockScreen: true)
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
                    LiveActivitySaveTimeView(freeCapacity: context.state.freeCapacity,
                                             seletedVideoFormat: VideoFormatCapacity(rawValue: context.state.videoFormatRaw)
                                             ?? .defaultQuality)
                    .padding(.top, 5)
                    .padding(.leading, 8)
                }
                
                DynamicIslandExpandedRegion(.trailing) {
                    CleanUpStatusView(cleanUpCapacity: context.state.cleanUpCapacity,
                                      seletedVideoFormat: VideoFormatCapacity(rawValue: context.state.videoFormatRaw)
                                      ?? .defaultQuality)
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
                Text("\(context.state.cleanUpCapacity.byteToGBStr())GB")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.pink300)
            } minimal: {}
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
        dynamicCapacityAttributes.ContentState(freeCapacity: 5, cleanUpCapacity: 42)
    }
    
    fileprivate static var starEyes: dynamicCapacityAttributes.ContentState {
        dynamicCapacityAttributes.ContentState(freeCapacity: 5, cleanUpCapacity: 42)
    }
}

#Preview("Notification", as: .content, using: dynamicCapacityAttributes.preview) {
    MoonCrystalWidgetExtentionLiveActivity()
} contentStates: {
    dynamicCapacityAttributes.ContentState.smiley
    dynamicCapacityAttributes.ContentState.starEyes
}
