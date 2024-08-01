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
    
    var favoriteIdol = "최애"
    let title = "를 위해 \n몇 GB 정리할까요?"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
                .tint(.gray900)
            }
            .padding(.horizontal, 20)
            .padding(.top, 14)
            .padding(.bottom, 22)
            
            
            Text(favoriteIdol + title)
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(.gray900)
                .padding(.bottom, 36)
                .padding(.leading, 24)
                .fixedSize()
            
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
                selectedCapacity = tempCapacity
                dismiss()
            } label: {
                Rectangle()
                    .foregroundStyle(.gray900)
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
