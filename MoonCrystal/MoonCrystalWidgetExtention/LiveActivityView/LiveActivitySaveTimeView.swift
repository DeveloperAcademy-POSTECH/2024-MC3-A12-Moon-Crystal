//
//  LiveActivitySaveTimeView.swift
//  MoonCrystalWidgetExtentionExtension
//
//  Created by sungkug_apple_developer_ac on 8/2/24.
//

import SwiftUI

struct LiveActivitySaveTimeView: View {
    @State var freeCapacity = 0
    
    var seletedVideoFormat: VideoFormatCapacity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            Text("촬영 가능 시간")
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(.white)
            Text(MediaCapacityConverter.getavailableTimeText(capacity: freeCapacity, format: seletedVideoFormat))
                .fixedSize()
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(.pink300)
        }
    }
}
