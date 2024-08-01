//
//  CapacitySettingView.swift
//  MoonCrystal
//
//  Created by seonu kim on 7/30/24.
//

import SwiftUI

struct CapacitySettingView: View {
    @State var selectedCapacity : Double = 0
    @State var useDirectInput = false
    @State var showTip = false
    
    var videoFormat: VideoFormatCapacity = .defaultQuality
    var idolGroup = "NCT"
    ///Slider의 max값을 결정하는 변수입니다.
    var maxCapacity: Double {
        if videoFormat == .defaultQuality {
            return 20
        }
        return 80
    }
    ///Slider의 간격 기준을 정하는 기준 변수입니다
    var step: Int {
        if videoFormat == .defaultQuality {
            return 5
        }
        return 20
    }
    var photoShot: Int {
        return MediaCapacityConverter.capacityToPhoto(capacity: Int(selectedCapacity) * 1_073_741_824)
    }
    var videoTime: Int {
        return MediaCapacityConverter.capacityToTime(capacity: Int(selectedCapacity) * 1_073_741_824, format: videoFormat)
    }
    let title = "를 위해 \n몇 GB 정리할까요?"
    let ment = "촬영할 수 있어요"
    
    var body: some View {
        ZStack {
            Color.gray50.ignoresSafeArea()
            VStack(spacing: 0) {
                HStack {
                    Text(idolGroup + title)
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundColor(.gray900)
                        .padding(.bottom, 54)
                        .padding(.leading, 20)
                        .fixedSize()
                    Spacer()
                }
                
                VStack(spacing: 24) {
                    Text("\(Int(selectedCapacity))GB")
                        .font(.system(size: 34, weight: .semibold))
                    
                    CustomSlider(selectedCapacity: $selectedCapacity, step: step, sliderRange: 0...maxCapacity)
                        .frame(height: 54)
                    
                    Button {
                        useDirectInput.toggle()
                    } label: {
                        Text("직접 입력")
                            .underline()
                            .foregroundStyle(.gray400)
                    }
                }
                .padding(.horizontal, 42)
                .padding(.bottom, 27)
                
                VStack(alignment: .leading, spacing: 16) {
                    HStack(alignment: .center, spacing: 0) {
                        if videoTime.minutesToHoursAndMinutes().minutes == 0 {
                            Text("동영상 \(videoTime.minutesToHoursAndMinutes().hours)시간 ")
                                .font(.system(size: 16, weight: .bold))
                            Text(ment)
                                .font(.system(size: 16))
                        } else {
                            Text("동영상 \(videoTime.minutesToHoursAndMinutes().hours)시간 \(videoTime.minutesToHoursAndMinutes().minutes)분 ")
                                .font(.system(size: 16, weight: .bold))
                            Text(ment)
                                .font(.system(size: 16))
                        }
                        Spacer()
                    }
                    .padding(.leading, 22)
                    .padding(.vertical, 24)
                    .background(.white)
                    .cornerRadius(12)
                    
                    HStack(alignment: .center, spacing: 0) {
                        Text("사진 \(String(photoShot))장 ")
                            .font(.system(size: 16, weight: .bold))
                        Text(ment)
                        Spacer()
                    }
                    .padding(.leading, 22)
                    .padding(.vertical, 24)
                    .background(.white)
                    .cornerRadius(12)
                }
                .padding(.horizontal, 20)
                
                NavigationLink {
                    //정리 시작 페이지로 이동
                } label: {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 68)
                        .foregroundStyle(.gray900)
                        .overlay(
                            Text("정리 시작하기")
                                .foregroundStyle(.white)
                        )
                }
                .padding(.horizontal, 20)
                .padding(.top, 60)
                
                NavigationLink {
                    //홈화면(메인 기본)으로 이동하기
                } label: {
                    Text("홈으로 가기")
                        .underline()
                        .foregroundStyle(.gray500)
                }
                .padding(.top, 24)
            }
        }
        .sheet(isPresented: $useDirectInput) {
            CapacityDirectInputView(selectedCapacity: $selectedCapacity, tempCapacity: selectedCapacity.rounded(.down))
                .presentationDetents([.height(250)])
                .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $showTip) {
            TipView()
                .presentationDetents([.height(280)])
                .presentationDragIndicator(.visible)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showTip.toggle()
                } label: {
                    Text("Tip")
                        .font(.system(size: 16))
                        .foregroundStyle(.pink300)
                }
            }
        }
    }
}

#Preview {
    CapacitySettingView()
}
