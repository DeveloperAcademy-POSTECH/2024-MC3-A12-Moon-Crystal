//
//  CleanUpStatusView.swift
//  MoonCrystalWidgetExtentionExtension
//
//  Created by sungkug_apple_developer_ac on 8/2/24.
//

import SwiftUI

struct CleanUpStatusView: View {

    @State var cleanUpCapacity = 0
    
    var seletedVideoFormat: VideoFormatCapacity
    var isLockScreen = false
    
    var body: some View {
        VStack(alignment: isLockScreen ? .leading : .trailing, spacing: 15) {
            Text("현재 정리중")
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(.white)
            HStack {
                Text("+\(MediaCapacityConverter.getavailableTimeText(capacity: cleanUpCapacity, format: seletedVideoFormat))")
                    .fixedSize()
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.pink300)
                Divider()
                    .overlay(.gray300)
                    .frame(minHeight: 1)
                Text("+\(cleanUpCapacity.byteToGBStr(format: "%.1f"))GB")
                    .fixedSize()
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.pink300)
            }
            .frame(height: 17)
        }
    }
}
