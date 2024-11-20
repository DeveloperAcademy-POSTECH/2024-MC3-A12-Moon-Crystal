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
    @State var tempCapacity = 0
    @State var text = ""
    
    var totalCapacity: Int
    var favoriteIdol: String
    let title = " 위해 \n몇 GB 정리할까요?"
    let alertMessage = "휴대폰 용량을 초과했어요"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .semibold))
                        .frame(height: 30)
                }
                .tint(.gray900)
            }
            .padding(.horizontal, 20)
            .padding(.top, 14)
            .padding(.bottom, 2)
            
            Text(JosaFomatter.postPositionText(favoriteIdol) + title)
                .font(.system(size: 24, weight: .bold))
                .frame(height: 67)
                .foregroundColor(.gray900)
                .padding(.bottom, 31)
                .padding(.leading, 24)
                .fixedSize()
            
            Text(alertMessage)
                .font(.system(size: 14))
                .foregroundStyle(tempCapacity <= totalCapacity ? .clear : .pink300)
                .padding(.leading, 24)
                .padding(.bottom, 8)
            
            HStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    Text("\(tempCapacity)")
                        .font(.system(size: 34, weight: .semibold))
                        .foregroundStyle(tempCapacity == 0 ? .gray400 : .gray700)
                }
                .defaultScrollAnchor(.trailing)
                Spacer()
                Text("GB")
                    .font(.system(size: 34, weight: .semibold))
                    .padding(.trailing, 41)
                    .foregroundStyle(.gray700)
            }
            .frame(height: 41)
            .padding(.leading, 22)
            .padding(.bottom, 5.5)
            
            Rectangle()
                .frame(height: 1)
                .padding(.leading, 22)
                .padding(.trailing, 34)
                .foregroundStyle(.pink300)
            
            Button {
                if tempCapacity <= totalCapacity {
                    selectedCapacity = Double(tempCapacity)
                    dismiss()
                }
            } label: {
                Rectangle()
                    .foregroundStyle(tempCapacity <= totalCapacity ? .gray900 : .gray400)
                    .frame(height: 65)
                    .overlay {
                        Text("확인")
                            .font(.system(size: 16))
                            .foregroundStyle(Color.white)
                    }
            }
            .padding(.top, 20)
            
            CustomNumPad(selectedNumber: $tempCapacity)
        }
        .onAppear {
            Tracking.Screen.capacityDirectInput.setTracking()
        }
    }
}
