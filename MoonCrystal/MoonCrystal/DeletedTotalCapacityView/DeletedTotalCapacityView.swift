//
//  DeletedTotalCapacityView.swift
//  MoonCrystal
//
//  Created by sungkug_apple_developer_ac on 8/1/24.
//

import SwiftUI

struct DeletedTotalCapacityView: View {
    @State var deletedTotalCapacity: String = "72GB"

    var userProfile: UserProfile?

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("최애를 위해 정리한 용량.zip")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(.gray900)
                Spacer()
            }
            .padding(.top, 120)
            
            GeometryReader { geometry in
                HStack {
                    VStack(spacing: 4) {
                        Text("정리한 용량")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(.gray)
                        Text("\(deletedTotalCapacity)")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.black)
                    }
                    .frame(width: geometry.size.width / 2 - 20)
                    
                    Divider()
                        .frame(height: 60)
                        .frame(minHeight: 1)
                        .overlay(.gray700)
                    
                    VStack(spacing: 4) {
                        Text("확보한 촬영 시간")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(.gray)
                        Text("\(deletedTotalCapacity)")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.black)
                    }
                    .frame(width: geometry.size.width / 2 - 20)
                }
                .frame(width: geometry.size.width, height: 60)
            }
            .frame(height: 60)
            .padding(.top, 40)
            
            MyFavoriteIdolInfoView(userProfile: userProfile)
                .padding(.top, 56)
            Spacer()
        }
        .padding(.horizontal)
        .background(Color.gray50)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    VStack{
        DeletedTotalCapacityView()
    }

}
