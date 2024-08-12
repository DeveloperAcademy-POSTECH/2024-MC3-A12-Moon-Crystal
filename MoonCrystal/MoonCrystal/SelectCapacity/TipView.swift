//
//  TipView.swift
//  MoonCrystal
//
//  Created by seonu kim on 7/31/24.
//

import SwiftUI

///미완성된 파일입니다.
struct TipView: View {
    @Environment(\.dismiss) var dismiss
    let title = "정리를 시작하기 전,\n얼마나 삭제할 지 감이 안 온다면?"
    var profileImage: Data?
    
    var body: some View {
        ZStack {
            Color(red: 0.96, green: 0.96, blue: 0.96)
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .top, spacing: 0) {
                    Text("Tip")
                        .font(.system(size: 20, weight: .bold))
                        .padding(.leading, 20)
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .semibold))
                            .frame(height: 30)
                            .padding(.trailing, 27)
                            .foregroundStyle(.gray700)
                    }
                }
                
                Text(title)
                    .font(.system(size: 24, weight: .bold))
                    .padding(.leading, 22)
                    .padding(.top, 23)
                    .foregroundColor(.gray700)
                    .fixedSize(horizontal: true, vertical: true)
                
                ZStack (alignment: .topLeading) {
                    VStack(alignment: .leading, spacing: 16) {
                        infoMessage(informationText: "사진 약 1700장을 삭제")
                        infoMessage(informationText: "5분 분량의 영상을 12개 삭제")
                        infoMessage(informationText: "1시간 분량의 영상을 삭제")
                    }
                    .padding(.trailing, 20)
                    
                    //나중에 이미지 연결할 때 이미지데이터 넣어주세요.
                    circleIcon(image: profileImage)
                        .frame(height: 72)
                        .offset(x: -48, y: -32)
                    
                }
                .padding(.leading, 72)
                .padding(.top, 66)
            }
        }
        .ignoresSafeArea()
    }
    
    private func infoMessage(informationText: String) -> some View {
        let GBInfoText = "5GB를 확보하려면"
        let endingText = "해야해요"
        
        return HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(GBInfoText)
                    .font(.system(size: 16))
                    .foregroundStyle(.gray800)
                HStack(spacing: 0) {
                    Text(informationText)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.pink300)
                    Text(endingText)
                        .font(.system(size: 16))
                        .foregroundStyle(.gray800)
                }
                .lineLimit(1)
                .minimumScaleFactor(0.5)

            }
            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 15)
        .background(Color.white)
        .clipShape(
            .rect(
                topLeadingRadius: 4,
                bottomLeadingRadius: 20,
                bottomTrailingRadius: 22,
                topTrailingRadius: 22
            )
        )
    }
    
    private func circleIcon(image: Data?) -> some View {
        ZStack {
            if let image = image, let uiimage = UIImage(data: image) {
                Image(uiImage: uiimage)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .padding(4.5)
                    .frame(width: 72)
            } else {
                Circle()
                    .frame(height: 72)
                    .foregroundStyle(.white)
                    .overlay {
                        Image(systemName: "person")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundStyle(.gray700)
                    }
            }
            Circle()
                .stroke(.pink300, lineWidth: 2)
                .frame(height: 72)
                .padding(1)
        }
    }
}
