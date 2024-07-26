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
            //            // Lock screen/banner UI goes here
            //            VStack {
            //                Text("FreeCapacity \(context.state.capacity)")
            //            }
            //            .activityBackgroundTint(Color.cyan)
            //            .activitySystemActionForegroundColor(Color.black)
            
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                }
                DynamicIslandExpandedRegion(.trailing) {
                }
                DynamicIslandExpandedRegion(.bottom) {
                    VStack{
                        Text("현재 확보된 용량 \(context.state.capacity)")
                    }
                }
            } compactLeading: {
                Text("Left\(context.state.capacity)")
                    .font(.system(size: 8.0))
            } compactTrailing: {
            
            } minimal: {
                Text("여유 공간 \(context.state.capacity)")
                    .font(.system(size: 8.0))
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
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
        dynamicCapacityAttributes.ContentState(capacity: "😀")
    }
    
    fileprivate static var starEyes: dynamicCapacityAttributes.ContentState {
        dynamicCapacityAttributes.ContentState(capacity: "🤩")
    }
}

#Preview("Notification", as: .content, using: dynamicCapacityAttributes.preview) {
    MoonCrystalWidgetExtentionLiveActivity()
} contentStates: {
    dynamicCapacityAttributes.ContentState.smiley
    dynamicCapacityAttributes.ContentState.starEyes
}
