//
//  UserProfileView.swift
//  MoonCrystal
//
//  Created by zaehorang on 7/29/24.
//

import SwiftUI

struct UserProfileView: View {
    var userProfile: UserProfile?
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        if let userProfile {
            UserProfileDetailView(userProfile: userProfile)
                .padding(.horizontal, 20)
                .background(.gray50)
                .ignoresSafeArea(.all, edges: .bottom)
        } else {
            VStack(spacing: 24) {
                // TODO: 텍스트 UI 수정
                Text("아직 작성된 프로필이 없어요\n프로필을 작성해주세요")
                    .font(.system(size: 16))
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                
                NavigationLink {
                    UserProfileCreationView()
                } label: {
                    Image("ProfileAddButton")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.gray50)
            .navigationTitle("프로필")
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
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
            }
        }
    }
}

#Preview {
    UserProfileView()
}
