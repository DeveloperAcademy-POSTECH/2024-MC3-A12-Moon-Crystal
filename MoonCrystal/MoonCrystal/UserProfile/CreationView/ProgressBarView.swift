//
//  ProgressBarView.swift
//  MoonCrystal
//
//  Created by zaehorang on 7/30/24.
//

import SwiftUI

struct ProgressBarView: View {
    @Binding var currentPage: Int
    private let totalPages = 3.0
    
    var body: some View {
        ProgressView(value: Double(currentPage), total: totalPages)
            .progressViewStyle(LinearProgressViewStyle())
            .tint(.pink)
    }
}

#Preview {
    ProgressBarView(currentPage: .constant(2))
}
