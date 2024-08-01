//
//  CustomSlider.swift
//  MoonCrystal
//
//  Created by seonu kim on 7/30/24.
//

import SwiftUI

// 일부 함수나 변수의 경우에 추후 간격 조정 및 수정을 위해 삭제하지 않고 내버려두었습니다.
struct CustomSlider: View {
    @Binding var value: Double
    @State var lastCoordinateValue: CGFloat = 0.0
    var step : Int = 20
    var sliderRange: ClosedRange<Double> = 0...80
    var trackColor = Color.gray100
    var thumbColor = Color.pink300
    var fontSize: CGFloat = 12
    
    var body: some View {
        GeometryReader { gr in
            let trackHeight = gr.size.height * 0.2
            let thumbSize = gr.size.height * 0.5
            let radius = gr.size.height * 0.2
            let minValue = thumbSize / 2
            let maxValue = gr.size.width - thumbSize / 2
            
            //지금 안씀, 필요없을 시 추후 삭제
//                        let trackPadding = thumbSize / 2
            
            let scaleFactor = (maxValue - minValue) / (sliderRange.upperBound - sliderRange.lowerBound)
            let lower = sliderRange.lowerBound
            let sliderVal = min(((self.value - lower) * scaleFactor + minValue), maxValue)
            
            VStack(alignment: .leading, spacing: 0) {
                ZStack {
                    RoundedRectangle(cornerRadius: radius)
                        .frame(height: trackHeight)
                        .foregroundColor(trackColor)
//                                            .padding(.horizontal, trackPadding)
                    HStack {
                        Circle()
                            .foregroundColor(thumbColor)
                            .frame(width: thumbSize, height: thumbSize)
                            .offset(x: sliderVal - thumbSize / 2)
                            .shadow(color: .black.opacity(0.12), radius: 6.5, x: 0, y: 6)
                            .shadow(color: .black.opacity(0.12), radius: 2, x: 0, y: 0.5)
                            .gesture(
                                DragGesture(minimumDistance: 0)
                                    .onChanged { change in
                                        let translation = change.translation.width
                                        if (abs(translation) < 0.1) {
                                            self.lastCoordinateValue = sliderVal
                                        }
                                        let nextCoordinateValue = max(minValue, min(maxValue, self.lastCoordinateValue + translation))
                                        self.value = (nextCoordinateValue - minValue) / scaleFactor + lower
                                    }
                            )
                        Spacer()
                    }
                }
                Spacer()
                ZStack {
                    ForEach((0...Int(sliderRange.upperBound)), id: \.self) { value in
                        if value % step == 0 {
                            Text("\(value)")
                                .font(.system(size: fontSize))
                                .offset(x:
                                            offsetForValue(
                                                value: value,
                                                scaleFactor: scaleFactor,
                                                thumbSize: thumbSize,
                                                minValue: minValue,
                                                maxValue: maxValue,
                                                isLast: value == Int(sliderRange.upperBound)
                                            )
                                )
                        }
                    }
                }
            }
        }
    }
    func paddingForValue(scaleFactor : CGFloat, thumbSize : CGFloat, step : Int) -> Double {
        return scaleFactor * CGFloat(step) - thumbSize / 2
    }
    private func offsetForValue(value: Int, scaleFactor: CGFloat, thumbSize: CGFloat, minValue: CGFloat, maxValue: CGFloat, isLast: Bool) -> CGFloat {
        let rawOffset = CGFloat(value) * scaleFactor * 1.05
        if value == 0 {
            return rawOffset * 1.05
        } else if isLast {
            return rawOffset
        } else {
            return rawOffset
        }
    }
}

#Preview(body: {
    CapacitySettingView()
})
