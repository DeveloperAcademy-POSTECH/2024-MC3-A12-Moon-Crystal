//
//  LiveActivitySaveTimeView.swift
//  MoonCrystalWidgetExtentionExtension
//
//  Created by sungkug_apple_developer_ac on 8/2/24.
//

import SwiftUI

struct LiveActivitySaveTimeView: View {
    @State var freeCapacity = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            Text("전체 확보 시간")
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(.white)
            Text("10h20m")
                .fixedSize()
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(.pink300)
        }
    }
}
