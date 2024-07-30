//
//  UserProfileDetailView.swift
//  MoonCrystal
//
//  Created by zaehorang on 7/30/24.
//

import PhotosUI
import SwiftUI

struct UserProfileDetailView: View {
    var userProfile: UserProfile
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isEditing = false
    @State private var userProfileInputData = UserProfileInputModel()
    
    init(userProfile: UserProfile) {
        self.userProfile = userProfile
        self._userProfileInputData = State(initialValue: UserProfileInputModel(favoriteIdol: userProfile.favoriteIdol,
                                                                               nickname: userProfile.nickname,
                                                                               imageData: userProfile.image))
    }
    
    var body: some View {
        VStack(spacing: 36) {
            profileImageSection
            textInputSection(title: "좋아하는 아이돌 이름",
                             text: $userProfileInputData.favoriteIdol)
            textInputSection(title: "팬덤이름", text:
                                $userProfileInputData.nickname)
        }
        .padding(.top, 36)
        .padding(.bottom, 104)
        .ignoresSafeArea(.all, edges: .bottom)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                backButton
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                editSaveButton
            }
        }
    }
    
    // 프로필 이미지 섹션
    private var profileImageSection: some View {
        VStack(spacing: 16) {
            HStack {
                Text("최애 사진")
                Spacer()
            }
            PhotoPickerButton(userProfileData: $userProfileInputData)
                .padding(.horizontal, 23)
                .disabled(!isEditing)
        }
    }
    
    // 텍스트 입력 섹션
    private func textInputSection(title: String, text: Binding<String>) -> some View {
        VStack(spacing: 16) {
            HStack {
                Text(title)
                Spacer()
            }
            TextField("", text: text)
                .frame(height: 48)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                .background(.red)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .disabled(!isEditing)
        }
    }
    
    // 뒤로 가기 버튼
    private var backButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            HStack(spacing: 3) {
                Image(systemName: "chevron.backward")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.black)
                
                Text("뒤로")
                    .foregroundColor(.black)
            }
        }
    }
    
    // 수정 & 저장 버튼
    private var editSaveButton: some View {
        Button {
            if isEditing {
                // Save changes
                userProfile.favoriteIdol = userProfileInputData.favoriteIdol
                userProfile.nickname = userProfileInputData.nickname
                if let imageData = userProfileInputData.imageData {
                    userProfile.image = imageData
                }
                presentationMode.wrappedValue.dismiss()
            } else {
                // Edit mode
                isEditing.toggle()
            }
        } label: {
            Text(isEditing ? "저장" : "수정")
                .foregroundColor(isEditing ? .black : .pink)
        }
    }
    
}
