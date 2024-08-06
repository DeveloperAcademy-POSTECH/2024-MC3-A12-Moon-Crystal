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

    @State private var navPath: [String] = []
    @State var totalCapacity = 0
    @State var freeCapacity = 0
    @State var favoriteIdol = "최애"
    @State private var progress: Float = 0.0
    
    @Query var userProfile: [UserProfile]
    
    var body: some View {
        NavigationStack(path: $navPath) {
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    NavigationLink {
                        UserProfileView(userProfile: userProfile.first)
                    } label: {
                        profileViewButton
                            .padding(.top, 74)
                            .padding(.trailing)
                    }
                }
                NavigationLink {
                    DeletedTotalCapacityView(userProfile: userProfile.first)
                } label: {
                    deletedStorageViewButton
                        .padding(.top, 28)
                        .padding(.horizontal)
                }
                availableTime
                    .padding(.leading, 40)
                Divider()
                    .foregroundStyle(.gray200)
                    .padding(.horizontal, 40)
                    .padding(.top, 33)
                currentCapacityTitle
                    .padding(.horizontal, 40)
                    .padding(.top, 39)
                ZStack {
                    ProgressHalfCircleView(progress: self.$progress, totalCapacity: $totalCapacity, freeCapacity: $freeCapacity)
                        .padding(.top, 32)
                        .padding(.horizontal, 50)
                    
                    NavigationLink(value: "FormatInput") {
                        cleanUpViewButton
                    }
                    .padding(.top, 260)
                    .padding(.horizontal)
                }
                Spacer()
            }
            .background(Color.gray50)
            .edgesIgnoringSafeArea(.all)
            .navigationDestination(for: String.self) { pathValue in
                if pathValue == "FormatInput" {
                    FormatInputView(path: $navPath, favoriteIdol: userProfile.first?.favoriteIdol ?? "최애", totalCapacity: Int(totalCapacity.byteToGB()), profileImage: userProfile.first?.image)
                } else if pathValue == "CleanUpView" {
                    CapacityCleanupView(path: $navPath, userProfile: userProfile.first)
                }
            }
        }
        .tint(.gray900)
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
        favoriteIdol = userProfile.first?.favoriteIdol ?? "최애"
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
                Text("\(favoriteIdol)\(MainHomeViewComponent.deletedStorage.title)")
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
                    .foregroundStyle(.white))
    }
}

#Preview {
    MainHomeView()
}

