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
        
    @Environment(\.scenePhase) var scenePhase
    
    @Binding var path: [String]
    
    @State var cleanUpCapacity = 0
    
    @State var freeCapacity = 0
        
    private let lottieFileName = "Timer"
    var userProfile: UserProfile?
        
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("지금까지 \(MediaCapacityConverter.capacityToHourAndMinute(capacity: cleanUpCapacity, format: seletedVideoFormat))(\(cleanUpCapacity.byteToGBStr(format: "%.1f"))GB)\n확보했어요")
                    .foregroundStyle(.gray900)
                    .font(.system(size: 28, weight: .bold))
                    .multilineTextAlignment(.leading)
                    .frame(height: 74)
                Spacer()
            }
            .padding(.top, 66)
            
            VStack(spacing: 38) {
                Text("\(JosaFomatter.postPositionText(userProfile?.favoriteIdol ?? "최애")) 위해 정리중 ...")
                    .foregroundStyle(.gray600)
                    .font(.system(size: 15, weight: .regular))
                
                LottieView(animation: .named(lottieFileName))
                    .playing(loopMode: .loop)
                    .frame(height: 160)
                    .scaledToFill()
            }
            .padding(.top, 60)
            
            Spacer()
                .frame(minHeight: 30, maxHeight: 86)
            
            HStack(alignment: .center, spacing: 49) {
                capacityTextView(title: "사용 가능 용량", value: "\(freeCapacity.byteToGBStr(format: "%.1f"))GB")
                Divider()
                    .background(.gray300)
                capacityTextView(title: "촬영 가능 시간", 
                                  value: MediaCapacityConverter.getavailableTimeText(
                                    capacity: freeCapacity, format: seletedVideoFormat))
            }
            .frame(height: 60)
            
            Spacer()
                .frame(minHeight: 20, maxHeight: 82)
            
            NavigationLink {
                EndCleanUpView(path: $path, userProfile: userProfile, cleanUpCapacity: cleanUpCapacity)
            } label: {
                RoundedRectangle(cornerRadius: 12)
                    .frame(height: 60)
                    .foregroundStyle(Color.gray900)
                    .overlay(
                        Text("정리 종료하기")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(.white))
            }
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
                Task {
                    await fetchCleanUpData()
                    await LiveActivityManager.updateLiveActivity()
                }
            }
        }
        .onAppear {
            Tracking.Screen.capacityCleanup.setTracking()
        }
    }
    
    private func fetchCleanUpData() async {
        cleanUpCapacity = await CapacityCalculator.getCleanUpFreeCapacity()
        freeCapacity = await CapacityCalculator.getFreeCapacity()
    }
    
    private func capacityTextView(title: String, value: String) -> some View {
        VStack(spacing: 6) {
            Text(title)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(.gray600)
            Text(value)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.gray900)
        }
    }
}
