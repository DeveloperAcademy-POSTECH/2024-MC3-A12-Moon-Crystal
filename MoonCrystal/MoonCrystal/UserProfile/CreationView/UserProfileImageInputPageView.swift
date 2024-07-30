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
        VStack(spacing: 40) {
            VStack(spacing: 42) {
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(page.title)
                            .font(.system(size: 28))
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                        
                        Text(page.description)
                            .font(.system(size: 16))
                            .fontWeight(.regular)
                    }
                    Spacer()
                }
                PhotoPickerButton(userProfileData: $userProfileData)
                    .padding(.horizontal, 23)
            }
            Button {
                let profile = UserProfile(favoriteIdol: userProfileData.favoriteIdol, 
                                          nickname: userProfileData.nickname,
                                          image: userProfileData.imageData!)
                modelContext.insert(profile)
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("완료하기")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(userProfileData.imageData == nil ? .gray : .black)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .disabled(userProfileData.imageData == nil)
        }
    }
}

#Preview {
    UserProfileImageInputPageView(currentPage: .constant(3), userProfileData: .constant(UserProfileInputModel(favoriteIdol: "뉴진스", nickname: "뉴뉴뉴", imageData: nil)), page: .idolImage)
}
