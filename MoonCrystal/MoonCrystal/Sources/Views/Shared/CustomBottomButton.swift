import SwiftUI

struct CustomBottomButton: View {
    let label: String
    var isDisabled = false
    
    let action: (() -> Void)?
    
    var body: some View {
        Button {
            action?()
        } label: {
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 68)
                .foregroundStyle(isDisabled ? .gray400 : .gray900)
                .overlay(
                    Text(label)
                        .font(.system(size: 15, weight: .regular))
                        .foregroundStyle(.white)
                )
        }
        .disabled(isDisabled)
        
    }
}

#Preview {
    CustomBottomButton(label: "얼마나 정리할지 알아보기") {
        print("Custom Button Tap")
    }
}
