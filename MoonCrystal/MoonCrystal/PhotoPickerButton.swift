//
//  PhotoPickerButton.swift
//  MoonCrystal
//
//  Created by zaehorang on 7/30/24.
//

import PhotosUI
import SwiftUI

struct PhotoPickerButton: View {
    @State var imageSelection: PhotosPickerItem?
    @Binding var userProfileData: UserProfileInputModel
    @Binding var isEditing: Bool
    
    var body: some View {
        PhotosPicker(
            selection: $imageSelection,
            matching: .images,
            photoLibrary: .shared()) {
                if let imageData = userProfileData.imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 307, height: 338)
                        .overlay(
                            ZStack(alignment: .center) {
                                if isEditing {
                                    Color.black.opacity(0.5)
                                    Image(systemName: "camera")
                                        .frame(width: 29)
                                        .tint(.gray200)
                                }
                            }
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                        
                } else {
                    Image("ProfileImagePlaceholder")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 307, height: 338)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }
            .onChange(of: imageSelection) {
                Task { @MainActor in
                    do {
                        if let data = try await imageSelection?.loadTransferable(type: Data.self) {
                            userProfileData.imageData = data
                        }
                    } catch {
                        print("❌ PhotoPickerButton: \(error.localizedDescription)")
                    }
                }
            }
    }
}
