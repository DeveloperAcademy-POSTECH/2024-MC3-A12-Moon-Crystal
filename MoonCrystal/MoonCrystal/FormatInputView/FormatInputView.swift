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
                Button(action: {
                    selectedType = .defaultQuality
                }, label: {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 60)
                        .foregroundStyle(.white)
                        .overlay(
                            Text("기본 화질")
                                .foregroundStyle(selectedType == .defaultQuality ? Color.pink300 : .black))
                })
                .frame(height: 60)
                .padding(.trailing, 9)
                Button(action: {
                    selectedType = .hd1080p60fps
                }, label: {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 60)
                        .foregroundStyle(.white)
                        .overlay(
                            Text("고화질")
                                .foregroundStyle(selectedType != .defaultQuality ? Color.pink300 : .black))
                })
                .frame(height: 60)
            }
            .padding(.top, 68)
            
            HStack {
                if selectedType != .defaultQuality {
                    VStack {
                        ForEach(VideoFormatCapacity.allCases, id: \.self) { format in
                            if format != .defaultQuality {
                                HStack {
                                    Button(action: {
                                        selectedType = format
                                    }, label: {
                                        HStack {
                                            Circle()
                                                .fill(selectedType == format ? Color.pink300 : Color.white)
                                                .frame(width: 12, height: 12)
                                                .overlay(
                                                    Circle()
                                                        .stroke(selectedType == format ? Color.pink300 : Color.gray, lineWidth: 1)
                                                )
                                            Text(format.detailInfo)
                                                .foregroundColor(.black)
                                                .font(.system(size: 16, weight: selectedType == format ? .bold : .regular))
                                        }
                                    })
                                    Spacer()
                                }
                                .padding(.vertical, 4)
                                .padding(.leading, 34)
                            }
                        }
                    }
                }
            }
            .frame(height: 260)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.top, 34)

            Button(action: {
                
            }, label: {
                RoundedRectangle(cornerRadius: 12)
                    .frame(height: 68)
                    .foregroundStyle(Color.gray900)
                    .overlay(
                        Text("고화질로 촬영할래요")
                            .foregroundStyle(.white))
            })
            .padding(.top, 42)
            Spacer()
        }
        .padding(.top, 164)
        .padding(.horizontal)
        .ignoresSafeArea()
        .background(Color.gray50)
    }
}

#Preview {
    FormatInputView()
}
