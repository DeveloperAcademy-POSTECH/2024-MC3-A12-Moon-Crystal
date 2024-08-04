//
//  LiveActivitySaveTimeView.swift
//  MoonCrystalWidgetExtentionExtension
//
//  Created by sungkug_apple_developer_ac on 8/2/24.
//

import SwiftUI

struct LiveActivitySaveTimeView: View {
    @AppStorage(UserDefaultsKeys.seletedVideoFormat.rawValue) var seletedVideoFormat: VideoFormatCapacity = .defaultQuality

    @State var freeCapacity = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            Text("전체 확보 시간\(seletedVideoFormat == .defaultQuality ? "/기본" : "/아님")")
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(.white)
            Text(MediaCapacityConverter.getavailableTimeText(capacity: freeCapacity, format: seletedVideoFormat))
                .fixedSize()
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(.pink300)
        }
    }
}
