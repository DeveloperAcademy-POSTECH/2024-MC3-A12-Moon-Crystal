//
//  FormatInputView.swift
//  MoonCrystal
//
//  Created by sungkug_apple_developer_ac on 7/31/24.
//

import SwiftUI

struct FormatInputView: View {
    @State var selectedType: VideoFormatCapacity? = .defaultQuality
    @State var isHighQualitySelected = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("어떤 화질로\n촬영하실 건가요?")
                    .font(.system(size: 28, weight: .semibold))
                Spacer()
            }
            HStack() {
                formatButton(buttonName: "기본 화질", type: .defaultQuality)
                    .padding(.trailing, 9)
                formatButton(buttonName: "고화질", type: nil)
            }
            .padding(.top, 68)
            
            HStack() {
                if isHighQualitySelected {
                    highFormatRadioButtons
                        .padding(.top, 10)
                }
            }
            .frame(height: 260)
            .padding(.top, 34)
            NavigationLink {
                if selectedType != nil {
                    // 여기서 selectedType 가지고 InputView로 넘어가면 될 것 같습니다
                }
            } label: {
                RoundedRectangle(cornerRadius: 12)
                    .frame(height: 68)
                    .foregroundStyle(selectedType == nil ? .gray400 : .gray900)
                    .overlay(
                        Text("\(selectedType ==  .defaultQuality ? "기본 화질" : "고화질")로 촬영할래요")
                            .foregroundStyle(.white))
            }
            .disabled(selectedType == nil)
            .padding(.top, 42)
            Spacer()
        }
        .padding(.top, 164)
        .padding(.horizontal)
        .ignoresSafeArea()
        .background(.gray50)
    }
    
    func formatButton(buttonName: String, type: VideoFormatCapacity?) -> some View {
        Button {
            selectedType = type
            if type == .defaultQuality {
                isHighQualitySelected = false
            } else {
                isHighQualitySelected = true
                selectedType = nil
            }
        } label: {
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 60)
                .foregroundStyle(.white)
                .overlay(
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isHighQualitySelected == (type != .defaultQuality) ? .pink300 : .black)
                        Text(buttonName)
                            .font(.system(size: 16, weight: selectedType == type ? .semibold : .regular))
                            .foregroundStyle(isHighQualitySelected == (type != .defaultQuality) ? .pink300 : .black)
                    }
                )
        }
    }
    
    var highFormatRadioButtons: some View {
        VStack(spacing: 0) {
            ForEach(VideoFormatCapacity.allCases, id: \.self) { format in
                if format != .defaultQuality {
                    HighFormatRadioButton(selectedType: $selectedType, format: format)
                        .padding(.top, 32)
                        .padding(.leading, 34)
                }
            }
            Spacer()
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    FormatInputView()
}
