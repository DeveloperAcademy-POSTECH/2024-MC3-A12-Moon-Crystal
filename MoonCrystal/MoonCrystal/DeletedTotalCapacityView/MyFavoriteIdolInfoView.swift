//
//  MyFavoriteIdolInfoView.swift
//  MoonCrystal
//
//  Created by sungkug_apple_developer_ac on 8/1/24.
//

import SwiftUI

struct MyFavoriteIdolInfoView : View {
    @State var deletedTotalCapacity: String = "72GB"
    var userProfile: UserProfile?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 307, height:  418)
                .foregroundStyle(.gray900)
                .overlay(
                    Group {
                        if let userProfile = userProfile, let uiImage = UIImage(data: userProfile.image) {
                            VStack(spacing: 0) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 307, height:  342)
                                    .clipShape(.rect(topLeadingRadius: 20, topTrailingRadius: 20))
                                
                                Spacer()
                            }
                        } else {
                            Text("아직 등록된 사진이 없어요")
                                .font(.system(size: 15))
                                .foregroundStyle(.gray50)
                                .padding(.bottom, 65)
                        }
                    }
                )
            
            VStack(spacing: 0) {
                Spacer()
                Divider()
                    .frame(width: 307)
                    .frame(minHeight: 1)
                    .overlay(.gray700)
                HStack {
                    VStack(alignment: .leading) {
                        Text("지금까지 \(userProfile?.favoriteIdol ?? "최애")를 위해")
                            .font(.system(size: 16))
                            .foregroundStyle(.white)
                        HStack {
                            Text("\(deletedTotalCapacity)")
                                .font(.system(size: 16, weight: .heavy))
                                .foregroundStyle(.pink300)
                            Text("정리했어요")
                                .font(.system(size: 16))
                                .foregroundStyle(.white)
                        }
                    }
                    .padding(.leading, 22)
                    Spacer()
                }
                .padding(.vertical, 18)
            }
            .frame(width: 307, height:  418)
            
            Capsule()
                .frame(width: 92,height: 40)
                .foregroundStyle(.pink100)
                .overlay(
                    Text("+12GB")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.gray900)
                )
                .offset(x: 120, y: -209)
        }
    }
}

#Preview {
    MyFavoriteIdolInfoView()
}
