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
            HStack {
                Text("정리가 종료됐어요!")
                    .font(.system(size: 24, weight: .semibold))
                Image("twinkle")
                    .resizable()
                    .frame(width: 34, height: 29)
                    .offset(y: -6)
                Spacer()
            }
            .padding(.top, 116)
            
            HStack {
                Text("포토카드에 당신의 마음을 담았어요")
                    .font(.system(size: 16))
                Spacer()
            }
            .padding(.top, 8)
            
            MyFavoriteIdolCardView(deletedTotalCapacity: deletedTotalCapacity, currentDeletedCapacity: cleanUpCapacity , isEndView: true, userProfile: userProfile)
                .padding(.top, 57)
            
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
                    .padding(.top, 65)
            }
            Spacer()
        }
        .padding(.horizontal)
        .background(Color.gray50)
        .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden()
        .onAppear {
            // 종료 클릭 시 다이나믹 종료
            LiveActivityManager.endLiveActivity()
        }
        
    }
}
