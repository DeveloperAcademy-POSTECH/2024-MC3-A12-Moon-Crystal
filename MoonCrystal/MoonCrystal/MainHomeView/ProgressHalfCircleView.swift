//
//  ProgressHalfCircleView.swift
//  MoonCrystal
//
//  Created by sungkug_apple_developer_ac on 7/31/24.
//

import SwiftUI

struct ProgressHalfCircleView: View {
    @Binding var progress: Float
    @Binding var totalCapacity: Int
    @Binding var freeCapacity: Int

    var body: some View {
        ZStack() {
            Circle()
                .trim(from: 0.5, to: 1.0)
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .opacity(0.3)
                .foregroundColor(Color("pink100"))
            Circle()
                .trim(from: 0.5, to: CGFloat(0.5 + self.progress / 2))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color("pink300"))
                .animation(.easeInOut(duration: 0.7), value: progress)
            VStack(spacing: 0) {
                Text("\(String(format: "%.0f", progress * 100))%")
                    .font(.system(size: 38, weight: .semibold))
                Spacer()
                    .frame(maxHeight: 15)
                VStack(spacing: 0) {
                    Text("\((totalCapacity - freeCapacity).byteToGBStr()) / \(totalCapacity.byteToGBStr()) GB")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Color("gray700"))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 6)
                }
                .background(Color("gray100"))
                .clipShape(RoundedRectangle(cornerRadius: 15))

            }
            .offset(y: -20)
        }
    }
}
