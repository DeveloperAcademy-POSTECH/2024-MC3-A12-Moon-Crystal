//
//  UserProfileTextInputPageView.swift
//  MoonCrystal
//
//  Created by zaehorang on 7/30/24.
//

import SwiftUI

struct UserProfileTextInputPageView: View {
    @Binding var currentPage: Int
    @Binding var userProfileData: UserProfileInputModel
    
    var page: UserProfileCreationPage
    
    var body: some View {
        VStack(spacing: 44) {
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
            
            TextField("", text: bindingForCurrentPage())
                .frame(height: 48)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.pink, lineWidth: 1)
                )
            
            Spacer()
            
            Button {
                withAnimation {
                    currentPage += 1
                }
            } label: {
                Text("다음")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(bindingForCurrentPage().wrappedValue.isEmpty ? .gray : .black)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .disabled(bindingForCurrentPage().wrappedValue.isEmpty)
        }
    }
    
    @ViewBuilder
    private var nextView: some View {
        if page == .favoriteIdol {
            UserProfileTextInputPageView(
                currentPage: $currentPage,
                userProfileData: $userProfileData, page: .nickname)
        } else if page == .nickname {
            UserProfileImageInputPageView(
                currentPage: $currentPage,
                userProfileData: $userProfileData)
        }
    }
    
    private func bindingForCurrentPage() -> Binding<String> {
        switch page {
        case .favoriteIdol:
            return $userProfileData.favoriteIdol
        case .nickname:
            return $userProfileData.nickname
        default:
            return .constant("")
        }
    }
}

#Preview {
    UserProfileTextInputPageView(currentPage: .constant(2), userProfileData: .constant(UserProfileInputModel(favoriteIdol: "뉴진스", nickname: "뉴뉴뉴", image: nil)), page: .nickname)
}
