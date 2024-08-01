//
//  TipView.swift
//  MoonCrystal
//
//  Created by seonu kim on 7/31/24.
//

import SwiftUI

///미완성된 파일입니다.
struct TipView: View {
    let title = "정리를 시작하기 전,\n얼마나 삭제할 지 감이 안 온다면?"
    var body: some View {
        VStack(alignment: .leading, spacing:0) {
            HStack(alignment: .top, spacing: 0) {
                Text("Tip")
                    .padding(.leading, 20)
                Spacer()
                Image(systemName: "xmark")
                    .font(.system(size: 16))
                    .padding(.trailing, 27)
            }
            Text(title)
                .font(.system(
                    size: 24,
                    weight: .semibold))
                .padding(.leading, 22)
                .padding(.top, 23)
                .foregroundColor(Color.gray700)
                .fixedSize(horizontal: true, vertical: true)
        }
        Rectangle()
            .cornerRadius(22, corners: [.topRight, .bottomRight])
            .cornerRadius(20, corners: .bottomLeft)
            .cornerRadius(4, corners: .topLeft)
            .frame(width: 200, height: 100)
    }
}

#Preview {
    TipView()
}
