//
//  CapacityDirectInputView.swift
//  MoonCrystal
//
//  Created by seonu kim on 7/31/24.
//

import SwiftUI

struct CapacityDirectInputView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedCapacity: Double
    @State var tempCapacity: Double = 0.0
    
    var fullCapacity : Int = 127
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
                .foregroundStyle(Int(tempCapacity) < fullCapacity ? .clear : .pink300)
                .padding(.leading, 24)
                .padding(.bottom, 8)
            
            HStack {
                TextField("0", value: $tempCapacity, formatter: NumberFormatter())
                    .keyboardType(.numberPad)
                    .font(.system(size: 34, weight: .semibold))
                
                Spacer()
                Text("GB")
                    .font(.system(size: 34, weight: .semibold))
                    .padding(.trailing, 41)
            }
            .padding(.leading, 22)
            
            Rectangle()
                .frame(height: 1)
                .padding(.leading, 22)
                .padding(.trailing, 34)
                .foregroundStyle(.pink300)
            
            Button {
                if Int(tempCapacity) < fullCapacity {
                    selectedCapacity = tempCapacity
                    dismiss()
                }
            } label: {
                Rectangle()
                    .foregroundStyle(Int(tempCapacity) < fullCapacity ? .gray900 : .gray400)
                    .frame(height: 65)
                    .overlay {
                        Text("확인")
                            .font(.system(size: 16))
                            .foregroundStyle(Color.white)
                    }
            }
            .padding(.top, 16)
        }
    }
}

#Preview {
    CapacitySettingView()
}
