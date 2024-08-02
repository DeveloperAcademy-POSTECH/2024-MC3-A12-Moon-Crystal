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
            
//            HStack {
//                VStack(alignment: .leading, spacing: 0) {
//                    Text("전체 확보 시간")
//                        .font(.system(size: 12, weight: .medium))
//                        .foregroundStyle(.white)
//                    
//                    Text("10h 20m")
//                        .font(.system(size: 24, weight: .semibold))
//                        .foregroundStyle(.pink300)
//                        .padding(.top, 6)
//        
//                    Text("현재 정리중")
//                        .font(.system(size: 12, weight: .medium))
//                        .foregroundStyle(.white)
//                        .padding(.top, 14)
//
//                    HStack {
//                        Text("+0h20m")
//                            .fixedSize()
//                            .font(.system(size: 16, weight: .semibold))
//                            .foregroundStyle(.pink300)
//                        Divider()
//                            .overlay(.gray300)
//                            .frame(minHeight: 1)
//                        
//                        Text("+100GB")
//                            .fixedSize()
//                            .font(.system(size: 16, weight: .semibold))
//                            .foregroundStyle(.pink300)
//                    }
//                    .frame(height: 17)
//                    .padding(.top, 7)
//                }
////                .padding()
//                Spacer()
//                Circle()
//                    .frame(width: 62)
//                Circle()
//                    .frame(width: 62)
////                LiveActivityButtonsView()
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .padding()
//            .activityBackgroundTint(Color.black)
//            .activitySystemActionForegroundColor(Color.black)
            
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    VStack(alignment: .leading, spacing: 7) {
                        Text("전체 확보 시간")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.white)
                        Text("10h20m")
                            .fixedSize()
                            .font(.system(size: 28, weight: .semibold))
                            .foregroundStyle(.pink300)
                    }
                    .padding(.top, 5)
                    .padding(.leading, 8)
                }
                
                DynamicIslandExpandedRegion(.trailing) {
                    VStack(alignment: .trailing, spacing: 15) {
                        Text("현재 정리중")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.white)
                        HStack {
                            Text("+0h20m")
                                .fixedSize()
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(.pink300)
                            Divider()
                                .overlay(.gray300)
                                .frame(minHeight: 1)
                            
                            Text("+0GB")
                                .fixedSize()
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(.pink300)
                        }
                        .frame(height: 17)
                    }
                    .padding(.top, 5)
                    .padding(.trailing, 8)
                }
                
                DynamicIslandExpandedRegion(.bottom, priority: 1) {
                    VStack{
                        LiveActivityButtonsView(isLoading: context.state.isLoading)
                    }
                    .padding(.horizontal, 8)
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
