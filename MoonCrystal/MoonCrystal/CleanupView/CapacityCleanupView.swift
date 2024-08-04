//
//  CapacityCleanupView.swift
//  MoonCrystal
//
//  Created by zaehorang on 8/1/24.
//

import Lottie
import SwiftUI

struct CapacityCleanupView: View {
    @AppStorage(UserDefaultsKeys.seletedVideoFormat.rawValue) var seletedVideoFormat: VideoFormatCapacity = .defaultQuality
    @AppStorage(UserDefaultsKeys.targetCapacity.rawValue) var targetCapacity: Int = 0
    @Environment(\.scenePhase) var scenePhase
    @Binding var path: [String]
    @State var deletedCapacity = 0
    @State var freeCapacity = 0
    @State var remainingCapacity = 0.0
    
    private let lottieFileName = "Timer"
    var favoriteIdol: String
        
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("지금까지 \(MediaCapacityConverter.capacityToTime(capacity: deletedCapacity, format: seletedVideoFormat))분(\(deletedCapacity.byteToGBStr(format: "%.1f"))GB)\n확보했어요")
                    .foregroundStyle(.gray900)
                    .font(.system(size: 28, weight: .semibold))
                    .multilineTextAlignment(.leading)
                    .frame(height: 74)
                Spacer()
            }
            .padding(.top, 66)
            
            VStack(spacing: 38) {
                Text("\(favoriteIdol)를 위해 정리중 ...")
                    .foregroundStyle(.gray600)
                    .font(.system(size: 15, weight: .regular))
                
                LottieView(animation: .named(lottieFileName))
                    .playing(loopMode: .loop)
                    .frame(height: 160)
                    .scaledToFill()
            }
            .padding(.top, 60)
            
            HStack(alignment: .center, spacing: 49) {
                capacityTextView(title: "현재 남은 용량", value: "\(String(format: "%.1f", remainingCapacity))GB")
                Divider()
                    .background(.gray300)
                capacityTextView(title: "촬영 가능 시간", 
                                  value: MediaCapacityConverter.getavailableTimeText(
                                    capacity: freeCapacity, format: seletedVideoFormat))
            }
            .frame(height: 60)
            .padding(.top, 86)
            
            Button {
                //TODO: 정리 종료 후 다이나믹 종료 추가
                path.removeAll()
            } label: {
                RoundedRectangle(cornerRadius: 12)
                    .frame(height: 60)
                    .foregroundStyle(Color.gray900)
                    .overlay(
                        Text("정리 종료하기")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(.white))
            }
            .padding(.top, 82)
            .padding(.bottom, 60)
            .ignoresSafeArea(.all, edges: .bottom)
        }
        .padding(.horizontal)
        .navigationBarBackButtonHidden()
        .task {
            await fetchCleanUpData()
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                // 나갔다가 다시 들어왔을 때 업데이트
                Task {
                    await fetchCleanUpData()
                }
            }
        }
    }
    
    private func fetchCleanUpData() async {
        print("cleanUp")
        deletedCapacity = await CapacityCalculator.getCleanUpFreeCapacity()
        freeCapacity = await CapacityCalculator.getFreeCapacity()
        remainingCapacity = Double(targetCapacity) - deletedCapacity.byteToGB()
    }
    
    private func capacityTextView(title: String, value: String) -> some View {
        VStack(spacing: 6) {
            Text(title)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(.gray600)
            Text(value)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.gray900)
        }
    }
}
