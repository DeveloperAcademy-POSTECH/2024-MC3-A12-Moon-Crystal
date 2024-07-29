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
    
    var body: some View {
        VStack {
            ProgressBarView(currentPage: $currentPage)
            Spacer()
            pageView
            Spacer()
        }
        .navigationTitle("프로필 작성")
        .padding()
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
                userProfileData: $userProfileData
            )
        default:
            Text("Invalid Page")
        }
    }
}


#Preview {
    UserProfileCreationView()
}
