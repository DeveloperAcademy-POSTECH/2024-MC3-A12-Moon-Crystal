//
//  CapacityDirectInputView.swift
//  MoonCrystal
//
//  Created by seonu kim on 7/31/24.
//

import SwiftUI

struct CapacityDirectInputView: View {
    @Environment(\.dismiss) var dismiss
    @FocusState private var isFocused: Bool
    @Binding var selectedCapacity: Double
    @State var tempCapacity: String = "0"
    @State var text = ""
    
    var totalCapacity: Int = 127
    var favoriteIdol = "최애"
    let title = "를 위해 \n몇 GB 정리할까요?"
    let alertMessage = "휴대폰 용량을 초과했어요"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .frame(height: 30)
                }
                .tint(.gray900)
            }
            .padding(.horizontal, 20)
            .padding(.top, 14)
            .padding(.bottom, 22)
            
            Text(favoriteIdol + title)
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(.gray900)
                .padding(.bottom, 11)
                .padding(.leading, 24)
                .fixedSize()
            
            Text(alertMessage)
                .font(.system(size: 14))
                .foregroundStyle(Int(tempCapacity) ?? 0 <= totalCapacity ? .clear : .pink300)
                .padding(.leading, 24)
                .padding(.bottom, 8)
            
            HStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    Text("\(tempCapacity)")
                        .font(.system(size: 34, weight: .semibold))
                }
                .defaultScrollAnchor(.trailing)
                Spacer()
                Text("GB")
                    .font(.system(size: 34, weight: .semibold))
                    .padding(.trailing, 41)
            }
            .foregroundStyle(.gray700)
            .padding(.leading, 22)
            
            Rectangle()
                .frame(height: 1)
                .padding(.leading, 22)
                .padding(.trailing, 34)
                .foregroundStyle(.pink300)
            
            Button {
                if Int(tempCapacity) ?? 0 <= totalCapacity {
                    selectedCapacity = Double(tempCapacity) ?? selectedCapacity
                    dismiss()
                }
            } label: {
                Rectangle()
                    .foregroundStyle(Int(tempCapacity) ?? 0 <= totalCapacity ? .gray900 : .gray400)
                    .frame(height: 65)
                    .overlay {
                        Text("확인")
                            .font(.system(size: 16))
                            .foregroundStyle(Color.white)
                    }
            }
            .padding(.top, 16)
            CustomNumPad(string: $tempCapacity)
        }
    }
}

#Preview {
    ContentView()
}
