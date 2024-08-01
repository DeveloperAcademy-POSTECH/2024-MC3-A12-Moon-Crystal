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
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(alignment: .center) {
                        Text("확보시간")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(.white)
                        Text("+ 0h 0m")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.pink300)
                    }
                    .padding(.bottom, 9)
                    
                    HStack(alignment: .center) {
                        Text("확보용량")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(.white)
                        Text("+ \(context.state.capacity)")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.pink300)
                    }
                }
                Spacer()
                Circle()
                Circle()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .activityBackgroundTint(Color.black)
            .activitySystemActionForegroundColor(Color.black)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.bottom, priority: 1) {
                    VStack(spacing: 0) {
                        HStack(alignment: .top, spacing: 0) {
                            VStack(alignment: .leading, spacing: 0) {
                                HStack(alignment: .center) {
                                    Text("확보시간")
                                        .font(.system(size: 15, weight: .regular))
                                        .foregroundStyle(.white)
                                    Text("+ 0h 0m")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundStyle(.pink300)
                                    Spacer()
                                }
                                .padding(.bottom, 4)
                                
                                HStack(alignment: .center) {
                                    Text("확보용량")
                                        .font(.system(size: 15, weight: .regular))
                                        .foregroundStyle(.white)
                                    Text("+ \(context.state.capacity)")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundStyle(.pink300)
                                }
                            }
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            
                            VStack(alignment: .leading, spacing: 0) {
                                HStack{
                                    Text("촬영가능")
                                        .font(.system(size: 15, weight: .regular))
                                        .foregroundStyle(.white)
                                    Spacer()
                                }
                                Text("+ \(context.state.capacity)")
                                    .font(.system(size: 32, weight: .semibold))
                                    .foregroundStyle(.pink300)
                            }
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        }
                        .padding(.bottom, 5)
                        LiveActivityButtonsView(isLoading: context.state.isLoading)
                    }
                    .frame(maxHeight: .infinity)
                    .padding(.horizontal, 5)
                    .padding(.bottom, 20)
                }
            } compactLeading: {
                Text("정리중")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.white)
            } compactTrailing: {
                Text("\(context.state.capacity)")
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
        dynamicCapacityAttributes.ContentState(capacity: "5.8GB")
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
