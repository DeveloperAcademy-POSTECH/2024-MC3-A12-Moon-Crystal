//
//  FormatInputView.swift
//  MoonCrystal
//
//  Created by sungkug_apple_developer_ac on 7/31/24.
//

import SwiftUI

struct FormatInputView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var path: [String]
    @Binding var selectedType: VideoFormatCapacity?
    @State var isHighQualitySelected = false
    
    var favoriteIdol: String
    var totalCapacity: Int
    var profileImage: Data?

    var body: some View {
        ZStack(alignment: .top) {
            Color.gray50.ignoresSafeArea()
            VStack(spacing: 0) {
                Spacer()
                    .frame(maxHeight: 66)
                HStack {
                    Text("어떤 화질로\n촬영하실 건가요?")
                        .font(.system(size: 28, weight: .bold))
                        .fixedSize()
                    Spacer()
                }
                
                HStack {
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
                
                Spacer()
                    .frame(maxHeight: 42)
                
                Button {
                    self.path.append("SettingView")
                } label: {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 68)
                        .foregroundStyle(selectedType == nil ? .gray400 : .gray900)
                        .overlay(
                            Text("\(selectedType ==  .defaultQuality ? "기본 화질" : "고화질")로 촬영할래요")
                                .font(.system(size: 15, weight: .regular))
                                .foregroundStyle(.white))
                }
                .disabled(selectedType == nil)
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 3) {
                        Image(systemName: "chevron.left")
                        Text("뒤로")
                    }
                    .font(.system(size: 16))
                    .foregroundStyle(.gray700)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    func formatButton(buttonName: String, type: VideoFormatCapacity?) -> some View {
        Button {
            // 애니메이션 없이 상태 변경
            withTransaction(Transaction(animation: nil)) {
                selectedType = type
                if type == .defaultQuality {
                    isHighQualitySelected = false
                } else {
                    isHighQualitySelected = true
                    selectedType = nil
                }
            }
        } label: {
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 60)
                .foregroundStyle(.white)
                .overlay(
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isHighQualitySelected == (type != .defaultQuality) ? .pink300 : .clear)
                        Text(buttonName)
                            .font(.system(size: 16, weight: selectedType == type ? .bold : .regular))
                            .foregroundStyle(isHighQualitySelected == (type != .defaultQuality) ? .pink300 : .gray600)
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

struct FormatInputView_Previews: PreviewProvider {
    @State static var path: [String] = []
    @State static var selectedType: VideoFormatCapacity? = nil
    
    static var previews: some View {
        FormatInputView(
            path: $path,
            selectedType: $selectedType,
            favoriteIdol: "Sample Idol",
            totalCapacity: 100,
            profileImage: nil
        )
    }
}
