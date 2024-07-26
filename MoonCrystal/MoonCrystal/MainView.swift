//
//  MainView.swift
//  MoonCrystal
//
//  Created by sungkug_apple_developer_ac on 7/26/24.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = CapacityManager.shared
    @State private var progress: Double = 0.1

    var body: some View {
        VStack {
            if viewModel.isEnd {
                Text("다이나믹 아일랜드 종료")
            }
            
            Slider(value: $progress, in: 0...1)
                .padding()
            Text("Total Space: \(viewModel.totalSpace)")
            Text("Free Space: \(viewModel.freeSpace)")
            Button {
                viewModel.startErase()
            } label: {
                Text("정리하기")
            }
            Button {
                viewModel.endLiveActivity()
            } label: {
                Text("끝내기")
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchDiskSpace()
        }
    }
}

#Preview {
    MainView()
}
