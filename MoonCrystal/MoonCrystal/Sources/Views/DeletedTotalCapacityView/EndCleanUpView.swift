//
//  EndCleanUpView.swift
//  MoonCrystal
//
//  Created by sungkug_apple_developer_ac on 8/2/24.
//

import SwiftUI

struct EndCleanUpView: View {
    @AppStorage(UserDefaultsKeys.deletedTotalCapacity.rawValue) var deletedTotalCapacity: Int = 0
    @Binding var path: [String]
    var userProfile: UserProfile?
    var cleanUpCapacity = 0
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(minHeight: 20)
            HStack {
                Text("정리가 종료됐어요!")
                    .font(.system(size: 24, weight: .semibold))
                Image("Twinkle")
                    .resizable()
                    .frame(width: 34, height: 29)
                    .offset(y: -6)
                Spacer()
            }
            
            HStack {
                Text("포토카드에 \(userProfile?.nickname ?? "당신")의 마음을 담았어요")
                    .font(.system(size: 16))
                    .foregroundStyle(.gray700)
                Spacer()
            }
            .padding(.top, 8)
            
            Spacer()
                .frame(maxHeight: 57)
            
            MyFavoriteIdolCardView(deletedTotalCapacity: deletedTotalCapacity, currentDeletedCapacity: cleanUpCapacity , isEndView: true, userProfile: userProfile)
            
            Spacer()
                .frame(maxHeight: 65)
            
            Button {
                path.removeAll()
            } label: {
                RoundedRectangle(cornerRadius: 12)
                    .frame(height: 68)
                    .foregroundStyle(Color.gray900)
                    .overlay(
                        Text("확인")
                            .foregroundStyle(.white)
                    )
            }
            Spacer()
                .frame(minHeight: 20)
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background{
            Color.gray50
                .ignoresSafeArea(.all)
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            // 종료 클릭 시 다이나믹 종료
            LiveActivityManager.endLiveActivity(isActive: true)
            
            Tracking.Screen.onboardingStep1.setTracking()
        }
    }
}
