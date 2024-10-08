//
//  PreCleanupInfoView.swift
//  MoonCrystal
//
//  Created by zaehorang on 8/1/24.
//

import Lottie
import SwiftUI

struct PreCleanupInfoView: View {
    @AppStorage(UserDefaultsKeys.seletedVideoFormat.rawValue) var seletedVideoFormat: VideoFormatCapacity = .defaultQuality

    @AppStorage(UserDefaultsKeys.preFreeCapacity.rawValue) var preFreeCapacity: Int = 0
    
    @Environment(\.scenePhase) var scenePhase
    
    @Environment(\.dismiss) var dismiss
    
    @State private var showNotificationAlert = false
    
    @StateObject var notificationManager = NotificationManager()
    
    @Binding var path: [String]
    
    @State var isAppBackgroundedByURL = false
    
    private let lottieFileName = "Arrow"
    private let title = "앱을 나가서\n정리를 시작해 보세요"
    private let description = "사진, 앱, 캐시 데이터를 삭제하면 실시간으로\n다이나믹 아일랜드에서 정리 현황을 알려줄게요"
    
    var favoritIdol = "최애"
    var videoFormat: VideoFormatCapacity = .defaultQuality
    
    var body: some View {
        VStack(spacing: 14) {
            HStack {
                Spacer()
                Button {
                    //TODO: 알림 설정
                    if notificationManager.isGranted {
                        // 알림 설정을 끄기 위해 설정으로 가기
                        isAppBackgroundedByURL = true
                        notificationManager.openSettings()
                    } else {
                        // 알림 설정을 켜기 위해 alert 띄우기
                        showNotificationAlert.toggle()
                    }
                } label: {
                    Circle()
                        .frame(width: 52)
                        .foregroundStyle(.white)
                        .overlay(Circle().stroke(.gray200, lineWidth: 0.5))
                        .overlay {
                            if notificationManager.isGranted {
                                Image(systemName: "bell")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 21)
                                    .tint(.gray600)
                            } else {
                                Image(systemName: "bell.slash")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 21)
                                    .tint(.gray600)
                            }
                        }
                }
                .alert(
                    "기기의 알림 설정이 꺼져있어요",
                    isPresented: $showNotificationAlert
                ) {
                    Button {
                        
                    } label: {
                        Text("취소")
                    }
                    
                    Button {
                        isAppBackgroundedByURL = true
                        notificationManager.openSettings()
                    } label: {
                        Text("알림 허용하기")
                    }
                } message: {
                    Text("휴대폰 설정 > 우리 앱 > 알림에서\n알림을 허용해 주세요")
                }
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 22) {
                    Text(title)
                        .foregroundStyle(.gray900)
                        .font(.system(size: 28, weight: .bold))
                        .multilineTextAlignment(.leading)
                    Text(description)
                        .foregroundStyle(.gray600)
                        .font(.system(size: 15, weight: .regular))
                        .multilineTextAlignment(.leading)
                        .lineSpacing(4)
                }
                Spacer()
            }
            
            Spacer()
            
            LottieView(animation: .named(lottieFileName))
                .playing(loopMode: .loop)
                .frame(height: 140)
                .scaledToFill()
        }
        .padding()
        .background(.gray50)
        .onAppear {
            // 정리 시작할 때 필요한 값들 설정
            seletedVideoFormat = videoFormat
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                Task {
                    await notificationManager.getCurrentSettings()
                    isAppBackgroundedByURL = false
                }
            } else if scenePhase == .inactive && !isAppBackgroundedByURL {
                Tracking.Event.appBackground.setTracking()
                
                // TODO: 나중에 다이나믹 아일랜드 시작 카운트다운 로직 추가해야됨
                Task {
                    await LiveActivityManager.startLiveActivity(favoritIdol: favoritIdol)
                    self.path.append("CleanUpView")
                }
            }
        }
        .task {
            preFreeCapacity = await CapacityCalculator.getFreeCapacity()
            await notificationManager.requestAuthorization()
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    LiveActivityManager.endLiveActivity()
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
        .onAppear {
            Tracking.Screen.preCleanupInfo.setTracking()
        }
    }
}
