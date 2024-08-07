//
//  CapacitySettingView.swift
//  MoonCrystal
//
//  Created by seonu kim on 7/30/24.
//

import SwiftUI

struct CapacitySettingView: View {
    @AppStorage(UserDefaultsKeys.seletedVideoFormat.rawValue) var seletedVideoFormat: VideoFormatCapacity = .defaultQuality
    @Environment(\.dismiss) var dismiss
    @Binding var path: [String]
    @State var selectedCapacity : Double = 0
    @State var useDirectInput = false
    @State var showTip = false
    @State var keyboardHeight : CGFloat = 0
    
    var totalCapacity : Int
    var videoFormat: VideoFormatCapacity = .defaultQuality
    var favoriteIdol: String
    var profileImage: Data?
    
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
        return MediaCapacityConverter.capacityToMinute(capacity: Int(selectedCapacity) * 1_073_741_824, format: videoFormat)
    }
    let title = "를 위해 \n몇 GB 정리할까요?"
    let ment = "촬영할 수 있어요"
    
    var body: some View {
        ZStack {
            Color.gray50.ignoresSafeArea()
            VStack(spacing: 0) {
                Spacer()
                HStack {
                    Text(favoriteIdol + title)
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundColor(.gray900)
                        .padding(.bottom, 54)
                        .padding(.leading, 20)
                        .fixedSize()
                    Spacer()
                }
                .padding(.top, 66)
                
                VStack(spacing: 24) {
                    Text("\(Int(selectedCapacity))GB")
                        .font(.system(size: 34, weight: .semibold))
                        .foregroundStyle(.gray800)
                    
                    CustomSlider(selectedCapacity: $selectedCapacity, step: step, sliderRange: 0...maxCapacity)
                        .frame(height: 54)
                    
                    Button {
                        useDirectInput.toggle()
                    } label: {
                        Text("직접 입력")
                            .underline()
                            .font(.system(size: 14, weight: .light))
                            .foregroundStyle(.gray400)
                    }
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 27)
                
                VStack(alignment: .leading, spacing: 16) {
                    HStack(alignment: .center, spacing: 0) {
                        Text("동영상 \(videoTime.minutesToHoursAndMinutes().hours)시간 \(videoTime.minutesToHoursAndMinutes().minutes)분 ")
                            .font(.system(size: 16, weight: .bold))
                        Text(ment)
                            .font(.system(size: 16))
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
                .foregroundStyle(.gray800)
                .padding(.horizontal, 20)
                
                NavigationLink {
                    PreCleanupInfoView(path: $path, favoritIdol: favoriteIdol)
                        .onAppear {
                            // 정리 시작할 때 필요한 값들 설정
                            seletedVideoFormat = videoFormat
                        }
                } label: {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 68)
                        .foregroundStyle(.gray900)
                        .overlay(
                            Text("정리 시작하기")
                                .font(.system(size: 16))
                                .foregroundStyle(.white)
                        )
                }
                .padding(.horizontal, 20)
                .padding(.top, 60)
                
                Button {
                    path.removeAll()
                } label: {
                    Text("홈으로 가기")
                        .underline()
                        .font(.system(size: 15))
                        .foregroundStyle(.gray500)
                }
                .padding(.top, 24)
                .padding(.bottom, 60)
            }
            .ignoresSafeArea(.keyboard)
        }
        .sheet(isPresented: $useDirectInput) {
            CapacityDirectInputView(selectedCapacity: $selectedCapacity, tempCapacity: Int(selectedCapacity), totalCapacity: totalCapacity, favoriteIdol: favoriteIdol)
                .presentationDetents([.height(588)])
                .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $showTip) {
            TipView(profileImage: profileImage)
                .presentationDetents([.height(476)])
                .presentationDragIndicator(.visible)
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
        .navigationBarBackButtonHidden(true)
    }
}
