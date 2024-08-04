//
//  MyFavoriteIdolCardView.swift
//  MoonCrystal
//
//  Created by sungkug_apple_developer_ac on 8/1/24.
//

import SwiftUI

struct MyFavoriteIdolCardView : View {
    //TODO: 나중에 정리된 총 용량이 저장되면 그값으로 변환
    var deletedTotalCapacity = 0
    var currentDeletedCapacity = 0
    var isEndView = false
    
    var userProfile: UserProfile?
    
    var body: some View {
        ZStack {
            cardBase
                .frame(width: 307, height:  418)
                .foregroundStyle(.gray900)
            
            VStack(spacing: 0) {
                Spacer()
                
                Divider()
                    .frame(width: 307)
                    .frame(minHeight: 1)
                    .overlay(.gray700)
                
                cardDescription
                    .padding(.leading, 22)
                    .padding(.vertical, 18)
            }
            .frame(width: 307, height:  418)
            
            if isEndView {
                Capsule()
                    .frame(width: 92,height: 40)
                    .foregroundStyle(.pink100)
                    .overlay(
                        Text("+\(currentDeletedCapacity)")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.gray900)
                    )
                    .offset(x: 120, y: -209)
            }
        }
    }
    
    var cardBase: some View {
        RoundedRectangle(cornerRadius: 20)
            .overlay(
                Group {
                    if let userProfile, let uiImage = UIImage(data: userProfile.image) {
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
    }
    
    var cardDescription: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("지금까지 \(userProfile?.favoriteIdol ?? "최애")를 위해")
                    .font(.system(size: 16))
                    .foregroundStyle(.white)
                HStack {
                    Text("\(deletedTotalCapacity.byteToGB())GB ")
                        .font(.system(size: 16, weight: .heavy))
                        .foregroundStyle(.pink300)
                    Text("정리했어요")
                        .font(.system(size: 16))
                        .foregroundStyle(.white)
                }
            }
            Spacer()
        }
    }
}

#Preview {
    MyFavoriteIdolCardView()
}
