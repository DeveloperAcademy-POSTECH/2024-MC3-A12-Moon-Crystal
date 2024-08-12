//
//  UserProfileImageInputPageView.swift
//  MoonCrystal
//
//  Created by zaehorang on 7/30/24.
//

import PhotosUI
import SwiftUI

struct UserProfileImageInputPageView: View {
    @Binding var currentPage: Int
    @Binding var userProfileData: UserProfileInputModel
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var modelContext
    
    var page: UserProfileCreationPage
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text(page.title)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(.gray900)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: true, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    
                    Text(page.description)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(.gray700)
                }
                Spacer()
            }
            .padding(.top, 40)
            
            Spacer(minLength: 40)
            
            PhotoPickerButton(userProfileData: $userProfileData, isEditing: .constant(false))
                .padding(.horizontal, 23)
            
            Spacer(minLength: 44)
            
            Button {
                let profile = UserProfile(favoriteIdol: userProfileData.favoriteIdol,
                                          nickname: userProfileData.nickname,
                                          image: userProfileData.imageData!)
                modelContext.insert(profile)
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("완료하기")
                    .font(.system(size: 15, weight: .regular))
                    .frame(height: 68)
                    .frame(maxWidth: .infinity)
                    .background(userProfileData.imageData == nil ? .gray400 : .gray900)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .disabled(userProfileData.imageData == nil)
            
            Spacer(minLength: 20)
                .frame(maxHeight: 86)
        }
        .background(.gray50)
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

#Preview {
    UserProfileImageInputPageView(currentPage: .constant(3), userProfileData: .constant(UserProfileInputModel(favoriteIdol: "뉴진스", nickname: "뉴뉴뉴", imageData: nil)), page: .idolImage)
}
