//
//  HighFormatRadioButton.swift
//  MoonCrystal
//
//  Created by sungkug_apple_developer_ac on 7/31/24.
//

import SwiftUI

struct HighFormatRadioButton: View {
    @Binding var selectedType: VideoFormatCapacity?
    var format: VideoFormatCapacity

    var body: some View {
        HStack {
            Button(action: {
                selectedType = format
            }, label: {
                HStack {
                    Circle()
                        .stroke(selectedType == format ? Color.pink300 : Color.gray, lineWidth: 1)
                        .frame(width: 18, height: 18)
                        .overlay(
                            Circle()
                                .fill(selectedType == format ? Color.pink300 : Color.white)
                                .frame(width: 12, height: 12)
                        )
                    Text(format.detailInfo)
                        .foregroundColor(.black)
                        .font(.system(size: 16, weight: selectedType == format ? .bold : .regular))
                }
            })
            Spacer()
        }
    }
}

