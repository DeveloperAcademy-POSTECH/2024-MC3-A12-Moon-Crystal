//
//  UserProfileDetailView.swift
//  MoonCrystal
//
//  Created by zaehorang on 7/30/24.
//

import PhotosUI
import SwiftUI

struct UserProfileDetailView: View {
    var userProfile: UserProfile
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var keyboardHeight : CGFloat = 0
    
    @State private var isEditing = false
    @State private var userProfileInputData = UserProfileInputModel()
    
    private let maxTextCount = 10
    
    init(userProfile: UserProfile) {
        self.userProfile = userProfile
        self._userProfileInputData = State(initialValue: UserProfileInputModel(favoriteIdol: userProfile.favoriteIdol,
                                                                               nickname: userProfile.nickname,
                                                                               imageData: userProfile.image))
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 36) {
                profileImageSection
                textInputSection(title: "좋아하는 아이돌 이름",
                                 text: $userProfileInputData.favoriteIdol)
                textInputSection(title: "팬덤 이름",
                                 text: $userProfileInputData.nickname)
            }
            .padding(.top, 0)
            .padding(.bottom, 104)
            .offset(y: keyboardHeight == 0 ? 0 : -(keyboardHeight / 2) - 90)
            .animation(.easeOut, value: 0.3)
            .keyboardHeight($keyboardHeight)
        }
        .padding(.top, 36)
        .padding(.bottom, 0)
        .navigationTitle(isEditing ? "프로필 수정" : "프로필")
        .navigationBarBackButtonHidden(true)
        
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                backButton
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                editSaveButton
            }
        }
    }
    
    // 프로필 이미지 섹션
    private var profileImageSection: some View {
        VStack(spacing: 16) {
            HStack {
                Text("최애 사진")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.gray700)
                Spacer()
            }
            PhotoPickerButton(userProfileData: $userProfileInputData, isEditing: $isEditing)
                .padding(.horizontal, 23)
                .disabled(!isEditing)
        }
    }
    
    // 텍스트 입력 섹션
    private func textInputSection(title: String, text: Binding<String>) -> some View {
        VStack(spacing: 16) {
            HStack {
                Text(title)
                    .font(.system(size: 16, weight:.bold))
                    .foregroundStyle(.gray700)
                Spacer()
            }
            TextField("", text: text)
                .frame(height: 48)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                .background(.white)
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.gray900)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    HStack {
                        Spacer()
                        Text(isEditing ? "\(text.wrappedValue.count)/\(maxTextCount)" : "")
                            .font(.system(size: 14))
                            .foregroundColor(.gray300)
                            .padding(.trailing, 16)
                    }
                )
                .disabled(!isEditing)
                .onChange(of: text.wrappedValue) {
                    if text.wrappedValue.count > maxTextCount {
                        // 최대 글자 수를 초과하면 초과 부분을 제거
                        text.wrappedValue = String(text.wrappedValue.prefix(maxTextCount))
                    }
                }
        }
    }
    
    // 뒤로 가기 버튼
    private var backButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            HStack(spacing: 3) {
                Image(systemName: "chevron.backward")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray700)
                
                Text("뒤로")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.gray700)
            }
        }
    }
    
    // 수정 & 저장 버튼
    private var editSaveButton: some View {
        Button {
            if isEditing {
                // Save changes
                userProfile.favoriteIdol = userProfileInputData.favoriteIdol
                userProfile.nickname = userProfileInputData.nickname
                if let imageData = userProfileInputData.imageData {
                    userProfile.image = imageData
                }
                isEditing.toggle()
            } else {
                // Edit mode
                isEditing.toggle()
            }
        } label: {
            Text(isEditing ? "저장" : "수정")
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(isEditing ? .pink300 : .gray700)
        }
    }
    
}

struct KeyboardProvider : ViewModifier {
    
    //키보드 높이값
    var keyboardHeight: Binding<CGFloat>
    
    func body(content: Content) -> some View {
        content
        //키보드 올라가기 직전 노티를 받으면 나오는 객체
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification),
                       perform: { notification in
                guard let userInfo = notification.userInfo,
                      let keyboardRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
                
                //키보드 높이값 . 바인딩 원본 객체 연결 -> 전달
                self.keyboardHeight.wrappedValue = keyboardRect.height
                
            })
        //키보드 닫기 전 보내는 노티 받으면 실행
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification),
                       perform: { _ in
                //키보드 높이값 0으로 변경
                self.keyboardHeight.wrappedValue = 0
            })
    }
}

public extension View {
    func keyboardHeight(_ state: Binding<CGFloat>) -> some View {
        self.modifier(KeyboardProvider(keyboardHeight: state))
    }
}
