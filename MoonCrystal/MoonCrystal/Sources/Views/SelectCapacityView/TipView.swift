//
//  TipView.swift
//  MoonCrystal
//
//  Created by seonu kim on 7/31/24.
//

import SwiftUI

struct TipView: View {
    @Environment(\.dismiss) var dismiss
    
    let title = "GB를 확보하려면\n얼마나 삭제해야 할까요?"
    let deleteGoal: DeleteGoalTip
    let photoNumber: Int
    let videoTime: Int
    
    init(videoFormat: VideoFormatCapacity) {
        deleteGoal = DeleteGoalTip(videoFormat: videoFormat)
        // MediaCapacityConverter활용 계산부분
        photoNumber = MediaCapacityConverter.capacityToPhoto(capacity: deleteGoal.standardByte)
        videoTime = MediaCapacityConverter.capacityToMinute(capacity: deleteGoal.standardByte, format: videoFormat)
    }
    
    var body: some View {
        ZStack {
            Color(red: 0.96, green: 0.96, blue: 0.96)
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .top, spacing: 0) {
                    Text("Tip")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.gray700)
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
                .padding(.top, 14)
                
                RoundedRectangle(cornerRadius: 14)
                    .stroke(.pink300, lineWidth: 1)
                    .frame(width: 71, height: 28)
                    .overlay {
                        Text(deleteGoal.videoFormatString)
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(.pink300)
                    }
                    .padding(.leading, 20)
                    .padding(.top, 43)
                
                Text("\(deleteGoal.standardGB)" + title)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.gray700)
                    .padding(.leading, 20)
                    .padding(.top, 12)
                    .fixedSize(horizontal: true, vertical: true)
                
                infoBox()
                    .padding(.top, 28)
                    .padding(.leading, 20)
                    .padding(.trailing, 21)
                
                Spacer()
            }
        }
        .ignoresSafeArea()
    }
    
    private func infoBox() -> some View {
        HStack {
            Spacer()
            VStack(spacing: 23) {
                Text("사진")
                    .font(.system(size: 16))
                    .foregroundStyle(.gray800)
                    .padding(.top, 23)
                
                Text("\(photoNumber)" + "장")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(.pink300)
                
                Spacer()
            }
            Spacer(minLength: 41)
            
            Rectangle()
                .frame(width: 1, height: 76)
                .foregroundStyle(Color(red: 0.9, green: 0.9, blue: 0.9))
                .padding(.top, 25)
                .padding(.bottom, 24)
            
            Spacer(minLength: 59)
            
            VStack(spacing: 23) {
                Text("동영상")
                    .font(.system(size: 16))
                    .foregroundStyle(.gray800)
                    .padding(.top, 23)
                
                Text("\(videoTime)" + "시간")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(.pink300)
                
                Spacer()
            }
            Spacer()
        }
        .frame(height: 125)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
        )
    }
}

#Preview {
    TipView(videoFormat: .defaultQuality)
}
