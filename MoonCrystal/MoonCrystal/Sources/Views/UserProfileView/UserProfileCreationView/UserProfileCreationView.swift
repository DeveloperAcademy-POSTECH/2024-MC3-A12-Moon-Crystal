//
//  UserProfileCreationView.swift
//  MoonCrystal
//
//  Created by zaehorang on 7/29/24.
//

import SwiftUI

struct UserProfileCreationView: View {
    @State private var currentPage = UserProfileCreationPage.favoriteIdol.rawValue
    @State private var userProfileData = UserProfileInputModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 0) {
            ProgressBarView(currentPage: $currentPage)
            pageView
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray50)
        .navigationTitle("프로필 작성")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    handleBackButton()
                } label: {
                    HStack(spacing: 3) {
                        Image(systemName: "chevron.backward")
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.gray700)
                        
                        Text("뒤로")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.gray700)
                    }
                }
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .onAppear {
            Tracking.Screen.profileCreation.setTracking()
        }
    }
    
    private func handleBackButton() {
        if currentPage > UserProfileCreationPage.favoriteIdol.rawValue {
            clearUserProfileData()
            withAnimation {
                currentPage -= 1
            }
        } else {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    private func clearUserProfileData() {
        if let page = UserProfileCreationPage(rawValue: currentPage) {
            switch page {
            case .nickname:
                userProfileData.nickname = ""
            case .idolImage:
                userProfileData.imageData = nil
            default:
                break
            }
        }
    }
    
    @ViewBuilder
    private var pageView: some View {
        switch UserProfileCreationPage(rawValue: currentPage) {
        case .favoriteIdol:
            UserProfileTextInputPageView(
                currentPage: $currentPage,
                userProfileData: $userProfileData,
                page: .favoriteIdol
            )
        case .nickname:
            UserProfileTextInputPageView(
                currentPage: $currentPage,
                userProfileData: $userProfileData,
                page: .nickname
            )
        case .idolImage:
            UserProfileImageInputPageView(
                currentPage: $currentPage,
                userProfileData: $userProfileData,
                page: .idolImage
            )
        default:
            Text("Invalid Page")
        }
    }
}

#Preview {
    UserProfileCreationView()
}
