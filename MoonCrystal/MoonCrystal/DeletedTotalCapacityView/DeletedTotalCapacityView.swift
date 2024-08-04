//
//  DeletedTotalCapacityView.swift
//  MoonCrystal
//
//  Created by sungkug_apple_developer_ac on 8/1/24.
//

import SwiftUI

struct DeletedTotalCapacityView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("deletedTotalCapacity") var deletedTotalCapacity: Int = UserDefaults.standard.integer(forKey: "deletedTotalCapacity")

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
            
            deletedTotalStatus
                .frame(height: 60)
                .padding(.top, 40)
            
            MyFavoriteIdolCardView(deletedTotalCapacity: deletedTotalCapacity, userProfile: userProfile)
                .padding(.top, 56)
            Spacer()
        }
        .padding(.horizontal)
        .background(.gray50)
        .edgesIgnoringSafeArea(.all)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 3) {
                        Image(systemName: "chevron.left")
                        Text("뒤로")
                    }
                    .font(.system(size: 17))
                    .foregroundStyle(.gray900)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    var deletedTotalStatus: some View {
        GeometryReader { geometry in
            HStack {
                VStack(spacing: 4) {
                    Text("정리한 용량")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.gray)
                    Text("\(deletedTotalCapacity.byteToGB())GB")
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
                    Text("\(MediaCapacityConverter.getavailableTimeText(capacity: deletedTotalCapacity, format: .defaultQuality))")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.black)
                }
                .frame(width: geometry.size.width / 2 - 20)
            }
            .frame(width: geometry.size.width, height: 60)
        }
    }
}

#Preview {
    VStack{
        DeletedTotalCapacityView()
    }
}
