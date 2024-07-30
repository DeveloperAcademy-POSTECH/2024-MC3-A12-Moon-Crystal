//
//  PhotoPickerButton.swift
//  MoonCrystal
//
//  Created by zaehorang on 7/30/24.
//

import PhotosUI
import SwiftUI

struct PhotoPickerButton: View {
    @Binding var uiImage: UIImage?
    @Binding var imageSelection: PhotosPickerItem?
    @Binding var userProfileData: UserProfileInputModel
    
    var body: some View {
        PhotosPicker(
            selection: $imageSelection,
            matching: .images,
            photoLibrary: .shared()) {
                Image(uiImage: uiImage ?? UIImage(named: "ProfileImagePlaceholder")!)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .onChange(of: imageSelection) {
                Task { @MainActor in
                    do {
                        if let data = try await imageSelection?.loadTransferable(type: Data.self) {
                            userProfileData.imageData = data
                            uiImage = UIImage(data: data)
                        }
                    } catch {
                        print("❌ PhotoPickerButton: \(error.localizedDescription)")
                    }
                }
            }
    }
}
