//
//  DummyView.swift
//  MoonCrystal
//
//  Created by seonu kim on 7/30/24.
//

import SwiftUI

//화면 연결 테스트를 위한 화면입니다. 연결 후 삭제해주세요.
struct DummyView: View {
    var body: some View {
        NavigationStack {
            Text("Hello, World!")
            NavigationLink("화면이동", destination: CapacitySettingView(videoFormat : .defaultQuality))
        }
    }
}

#Preview {
    DummyView()
}
