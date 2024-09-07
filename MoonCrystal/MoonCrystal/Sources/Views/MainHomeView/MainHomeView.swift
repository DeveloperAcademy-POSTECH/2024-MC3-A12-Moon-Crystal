//
//  MainHomeView.swift
//  MoonCrystal
//
//  Created by sungkug_apple_developer_ac on 7/31/24.
//

import SwiftData
import SwiftUI

struct MainHomeView: View {
    @AppStorage(UserDefaultsKeys.runLiveActivity.rawValue) var runLiveActivity: Bool = false
    @AppStorage(UserDefaultsKeys.hasSeenGuide.rawValue) var hasSeenGuide: Bool = false
    
    @State private var navPath: [String] = []
    @State var totalCapacity = 0
    @State var freeCapacity = 0
    @State private var progress: Float = 0.0
    @State var selectedType: VideoFormatCapacity? = .defaultQuality
    
    @Query var userProfile: [UserProfile]
    
    var body: some View {
        NavigationStack(path: $navPath) {
            ZStack {
                Color.gray50.ignoresSafeArea()
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Spacer()
                        NavigationLink {
                            UserProfileView(userProfile: userProfile.first)
                        } label: {
                            profileViewButton
                        }
                    }
                    
                    NavigationLink {
                        DeletedTotalCapacityView(userProfile: userProfile.first)
                    } label: {
                        deletedStorageViewButton
                            .padding(.top, 28)
                    }
                    
                    availableTime
                        .padding(.leading, 20)
                    
                    Divider()
                        .foregroundStyle(.gray200)
                        .padding(.horizontal, 20)
                        .padding(.top, 33)
                    
                    currentCapacityTitle
                        .padding(.horizontal, 20)
                        .padding(.top, 39)
                    
                    ZStack {
                        ProgressHalfCircleView(progress: self.$progress, totalCapacity: $totalCapacity, freeCapacity: $freeCapacity)
                            .padding(.top, 32)
                            .padding(.horizontal, 30)
                        VStack {
                            Spacer()
                                .frame(maxHeight: 260)
                            NavigationLink(value: "FormatInput") {
                                cleanUpViewButton
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
            .navigationDestination(for: String.self) { pathValue in
                // 네비게이션 링크 연결 방식 통일
                if pathValue == "FormatInput" {
                    
                    FormatInputView(path: $navPath, selectedType: $selectedType, favoriteIdol: userProfile.first?.favoriteIdol ?? "최애", totalCapacity: Int(totalCapacity.byteToGB()), profileImage: userProfile.first?.image)
                    
                } else if pathValue == "SettingView" {
                    
                    CapacitySettingView(path: $navPath, totalCapacity: Int(totalCapacity.byteToGB()), videoFormat: selectedType!, favoriteIdol: userProfile.first?.favoriteIdol ?? "최애", profileImage: userProfile.first?.image)
                    
                } else if pathValue == "PreCleanUpView" {
                    
                    PreCleanupInfoView(path: $navPath, favoritIdol: userProfile.first?.favoriteIdol ?? "최애", videoFormat: selectedType!)
                    
                } else if pathValue == "CleanUpView" {
                    
                    CapacityCleanupView(path: $navPath, userProfile: userProfile.first)
            
                }
            }
        }
        .tint(.gray900)
        .overlay {
            if !hasSeenGuide {
                Button {
                    hasSeenGuide = true
                } label: {
                    Image("ProfileTip")
                        .resizable()
                        .scaledToFill()
                }
            }
        }
        .task {
            await fetchCapacityData()
        }
        .onChange(of: runLiveActivity) {
            if !runLiveActivity {
                navPath.removeAll()
            }
        }
        .onChange(of: navPath) {
            if navPath.isEmpty {
                Task {
                    await fetchCapacityData()
                }
            }
        }
    }
    
    private func fetchCapacityData() async {
        totalCapacity = await CapacityCalculator.getTotalCapacity()
        if totalCapacity > 0 {
            freeCapacity = await CapacityCalculator.getFreeCapacity()
            progress = Float(Double(totalCapacity - freeCapacity) / Double(totalCapacity))
        }
    }
    
    var profileViewButton: some View {
        ZStack {
            if userProfile.first?.image == nil {
                Circle()
                    .frame(width: 52, height: 52)
                    .foregroundStyle(.white)
                    .overlay(Circle().stroke(Color.gray200, lineWidth: 0.5))
                Image(systemName: "person")
                    .fontWeight(.bold)
                    .foregroundStyle(Color.gray700)
                    .frame(width: 24, height: 24)
            } else {
                if let userProfile = userProfile.first, let uidata =  UIImage(data: userProfile.image) {
                    Image(uiImage: uidata)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 52, height: 52)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .overlay(Circle().stroke(Color.gray200, lineWidth: 0.5))
                }
            }
        }
    }
    
    var deletedStorageViewButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 32)
                .frame(height: 64)
                .foregroundStyle(.white)
                .overlay(RoundedRectangle(cornerRadius: 32).stroke(Color.gray200, lineWidth: 0.5))
            HStack(spacing: 0) {
                Image(systemName: "heart.fill")
                    .frame(width: 18, height: 18)
                    .foregroundStyle(Color.pink200)
                    .padding(.trailing, 12)
                Text("\(MainHomeViewComponent.deletedStorage.title)")
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
                Text("\(JosaFomatter.postPositionText(userProfile.first?.favoriteIdol ?? "최애"))\(MainHomeViewComponent.availableTime.title)")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.gray700)
                    .padding(.top, 38)
                Text("\(MediaCapacityConverter.getavailableTimeText(capacity: freeCapacity, format: .defaultQuality))")
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
                    .font(.system(size: 15, weight: .regular))
                    .foregroundStyle(.white))
    }
}

#Preview {
    MainHomeView()
}
