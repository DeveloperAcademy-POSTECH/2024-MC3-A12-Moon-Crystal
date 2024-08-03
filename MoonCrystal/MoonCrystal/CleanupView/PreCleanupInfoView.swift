//
//  PreCleanupInfoView.swift
//  MoonCrystal
//
//  Created by zaehorang on 8/1/24.
//

import Lottie
import SwiftUI

struct PreCleanupInfoView: View {
    @Environment(\.dismiss) var dismiss
    private let lottieFileName = "Arrow"
    
    private let title = "앱을 나가서\n정리를 시작해 보세요"
    private let description = "사진, 앱, 캐시 데이터를 삭제하면 실시간으로\n다이나믹 아일랜드에서 정리 현황을 알려줄게요"
    
    @StateObject var notificationManager = NotificationManager()
    
    var body: some View {
        VStack(spacing: 14) {
            HStack {
                Spacer()
                Button {
                    //TODO: 알림 설정
                    if notificationManager.isGranted {
                        print("동의")
                        //TODO: 내부에서 알림 안받는 로직 추가하기
                    } else {
                        //TODO: 얼럿 띄어서 설정 뷰로 넘어가는 로직 추가하기
                        notificationManager.openSettings()
                    }
                } label: {
                    Circle()
                        .frame(width: 52)
                        .foregroundStyle(.white)
                        .overlay {
                            if notificationManager.isGranted {
                                Image(systemName: "bell")
                                    .tint(.gray600)
                            } else {
                                Image(systemName: "bell.slash")
                                    .tint(.gray600)
                            }
                        }
                }
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 22) {
                    Text(title)
                        .foregroundStyle(.gray900)
                        .font(.system(size: 28, weight: .semibold))
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
        .task {
            LiveActivityManager.startLiveActivity(freeCapacity: "start")
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
                    .font(.system(size: 17))
                    .foregroundStyle(.gray900)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    PreCleanupInfoView()
}
