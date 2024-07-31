//
//  FormatInputView.swift
//  MoonCrystal
//
//  Created by sungkug_apple_developer_ac on 7/31/24.
//

import SwiftUI

struct FormatInputView: View {
    @State var selectedType: VideoFormatCapacity = .defaultQuality
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("어떤 화질로\n촬영하실 건가요?")
                    .font(.system(size: 28, weight: .semibold))
                Spacer()
            }
            HStack() {
                formatButton(buttonName: "기본 화면", type: .defaultQuality)
                    .padding(.trailing, 9)
                formatButton(buttonName: "고화질", type: .hd1080p60fps)
            }
            .padding(.top, 68)
            
            HStack() {
                if selectedType != .defaultQuality {
                    highFormatRadioButtons
                        .padding(.top, 10)
                }
            }
            .frame(height: 260)
            .padding(.top, 34)
            
            NavigationLink {
                // 여기서 selectedType 가지고 InputView로 넘어가면 될 것 같습니다
            } label: {
                RoundedRectangle(cornerRadius: 12)
                    .frame(height: 68)
                    .foregroundStyle(Color.gray900)
                    .overlay(
                        Text("\(selectedType ==  .defaultQuality ? "기본 화질" : "고화질")로 촬영할래요")
                            .foregroundStyle(.white))
            }
            .padding(.top, 42)
            Spacer()
        }
        .padding(.top, 164)
        .padding(.horizontal)
        .ignoresSafeArea()
        .background(Color.gray50)
    }
    
    func formatButton(buttonName: String, type: VideoFormatCapacity) -> some View {
        Button(action: {
            selectedType = type
        }) {
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 60)
                .foregroundStyle(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 12).stroke(selectedType == type ? Color.pink300 : .black)
                )
                .overlay(
                    Text(buttonName)
                        .font(.system(size: 16, weight: selectedType == type ? .semibold : .regular))
                        .foregroundStyle(selectedType == type ? Color.pink300 : .black)
                )
        }
    }
    
    var highFormatRadioButtons: some View {
        VStack(spacing: 0) {
            ForEach(VideoFormatCapacity.allCases, id: \.self) { format in
                if format != .defaultQuality {
                    highFormatRadioButton(selectedType: $selectedType, format: format)
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
