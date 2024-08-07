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
    
    private let maxTextCount = 10
    
    var page: UserProfileCreationPage
    
    var body: some View {
        VStack(spacing: 44) {
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
            
            VStack(alignment: .leading, spacing: 8) {
                TextField("", text: bindingForCurrentPage())
                    .font(.system(size: 16, weight: .regular))
                    .frame(height: 48)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(
                        HStack {
                            Spacer()
                            Text("\(bindingForCurrentPage().wrappedValue.count)/\(maxTextCount)")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.gray300)
                                .padding(.trailing, 16)
                        }
                    )
                    .onChange(of: bindingForCurrentPage().wrappedValue) {
                        if bindingForCurrentPage().wrappedValue.count > maxTextCount {
                            // 최대 글자 수를 초과하면 초과 부분을 제거
                            bindingForCurrentPage().wrappedValue = String(bindingForCurrentPage().wrappedValue.prefix(maxTextCount))
                        }
                    }
            }
            
            Spacer()
            
            Button {
                withAnimation {
                    currentPage += 1
                }
            } label: {
                Text("다음")
                    .font(.system(size: 16, weight: .regular))
                    .padding()
                    .frame(height: 68)
                    .frame(maxWidth: .infinity)
                    .background(bindingForCurrentPage().wrappedValue.isEmpty ? .gray400 : .gray900)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .disabled(bindingForCurrentPage().wrappedValue.isEmpty)
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
    UserProfileTextInputPageView(currentPage: .constant(2), userProfileData: .constant(UserProfileInputModel(favoriteIdol: "뉴진스", nickname: "일이삼사오육칠팔구십", imageData: nil)), page: .nickname)
}
