//
//  MainHomeView.swift
//  MoonCrystal
//
//  Created by sungkug_apple_developer_ac on 7/31/24.
//

import SwiftData
import SwiftUI

struct MainHomeView: View {
    @State var availableTimeText = "0h 36m"
    @State var name = "최애"
    @State private var progress: Float = 0.0
    @State var uiImageName: UIImage? = nil
    
    @Query var userProfile: [UserProfile]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    NavigationLink {
                        // TODO: UserProfileView 연결
                        UserProfileView(userProfile: userProfile.first)
                    } label: {
                        profileViewButton
                            .padding(.top, 74)
                            .padding(.trailing)
                    }
                }
                NavigationLink {
                    // TODO: 그동안 삭제된 양 확인하는 뷰 연결
                } label: {
                    deletedStorageViewButton
                        .padding(.top, 28)
                        .padding(.horizontal)
                }
                availableTime
                    .padding(.leading, 40)
                Divider()
                    .foregroundStyle(Color.gray200)
                    .padding(.horizontal, 40)
                    .padding(.top, 33)
                currentCapacityTitle
                    .padding(.horizontal, 40)
                    .padding(.top, 39)
                ZStack {
                    ProgressHalfCircleView(progress: self.$progress)
                        .padding(.top, 32)
                        .padding(.horizontal, 50)
                    
                    NavigationLink {
                    } label: {
                        cleanUpViewButton
                    }
                    .padding(.top, 260)
                    .padding(.horizontal)
                }
                Spacer()
            }
            .background(Color.gray50)
            .edgesIgnoringSafeArea(.all)
        }
        .tint(.black)
        .onAppear {
            // TODO: 데이터 fetch
            availableTimeText = "1h 30m"
            name = "최애"
            progress = 0.8
            //uiImageName =
        }
    }
    
    var profileViewButton: some View {
        ZStack {
            if uiImageName == nil {
                Circle()
                    .frame(width: 52, height: 52)
                    .foregroundStyle(.white)
                    .overlay(Circle().stroke(Color.gray200, lineWidth: 0.5))
                Image(systemName: "person")
                    .fontWeight(.bold)
                    .foregroundStyle(Color.gray700)
                    .frame(width: 24, height: 24)
            } else {
                Image(uiImage: uiImageName!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 52, height: 52)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .overlay(Circle().stroke(Color.gray200, lineWidth: 0.5))
            }
        }
    }
    
    var deletedStorageViewButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 32)
                .frame(height: 64)
                .foregroundStyle(.white)
            HStack {
                Image(systemName: "heart.fill")
                    .frame(width: 18, height: 18)
                    .foregroundStyle(Color.pink200)
                    .padding(.trailing, 12)
                Text("\(name)\(MainHomeViewComponent.deletedStorage.title)")
                    .font(.system(size: 15))
                Spacer()
                Image(systemName: "chevron.right")
                    .frame(height: 17)
            }
            .padding(.horizontal)
        }
    }
    
    var availableTime: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0.0) {
                Text(MainHomeViewComponent.availableTime.title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.gray700)
                    .padding(.top, 38)
                Text("\(availableTimeText)")
                    .font(.system(size: 48, weight: .semibold))
                    .foregroundStyle(Color.gray900)
                    .padding(.top, 16)
            }
            Spacer()
        }
    }
    
    var currentCapacityTitle: some View {
        HStack {
            Text(MainHomeViewComponent.currentCapacity.title)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(Color.gray700)
            Spacer()
        }
    }
    
    var cleanUpViewButton: some View {
        RoundedRectangle(cornerRadius: 12)
            .frame(height: 68)
            .foregroundStyle(Color.gray900)
            .overlay(
                Text(MainHomeViewComponent.CleanUpButton.title)
                    .foregroundStyle(.white))
    }
}

#Preview {
    MainHomeView()
}

