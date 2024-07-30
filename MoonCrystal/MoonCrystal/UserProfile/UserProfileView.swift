//
//  UserProfileView.swift
//  MoonCrystal
//
//  Created by zaehorang on 7/29/24.
//

import SwiftUI

struct UserProfileView: View {
    // TODO: 로컬에서 프로필 저장 유무 받아오기
    // 이전 뷰에서도 프로필을 보여주니까 해당 값의 유무에 따라 나누면 될 듯
    var isUserProfileSaved = false
    
    var body: some View {
        if isUserProfileSaved {
            // TODO: 프로필 뷰 그리기
            Image("newjeans")
                .navigationTitle("프로필")
        } else {
            VStack(spacing: 24) {
                // TODO: 텍스트 UI 수정
                Text("아직 작성된 프로필이 없어요\n프로필을 작성해주세요")
                    .font(.system(size: 18))
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    
                NavigationLink {
                    UserProfileCreationView()
                } label: {
                    // TODO: 버튼 이미지 수정
                    Image("ProfileAddButton")
                }
            }
            .navigationTitle("프로필")
        }
    }
}

#Preview {
    UserProfileView()
}
