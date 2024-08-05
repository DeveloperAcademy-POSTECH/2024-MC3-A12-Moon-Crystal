//
//  CustomNumpad.swift
//  MoonCrystal
//
//  Created by seonu kim on 8/5/24.
//

import SwiftUI

struct CustomNumPad: View {
    @Binding var selectedNumber: Int
    let maxDigits: Int = 18
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 6) {
                NumPadRow(keys: [.one, .two, .three], action: keyWasPressed(_:))
                NumPadRow(keys: [.four, .five, .six], action: keyWasPressed(_:))
                NumPadRow(keys: [.seven, .eight, .nine], action: keyWasPressed(_:))
                NumPadRow(keys: [.none, .zero, .backspace], action: keyWasPressed(_:))
            }
            .padding(.top, 6)
            Spacer()
        }
        .frame(height: 291.0)
        .background(Color(red: 0.81, green: 0.82, blue: 0.84))
    }
    private func keyWasPressed(_ key: NumPadKey) {
        if String(selectedNumber).count > maxDigits-1 && key != .backspace {
            print("❌ Over the max digit for Int64 \(selectedNumber)")
            return
        }
        switch key {
        case .backspace:
        if selectedNumber != 0 {
            selectedNumber /= 10
        }
        case .none: return
        case _ where selectedNumber == 0 : selectedNumber = key.rawValue
        default: selectedNumber = selectedNumber * 10 + key.rawValue
        }
    }
}

enum NumPadKey: Int {
    case zero = 0, one, two, three, four, five, six, seven, eight, nine
    case backspace = -1
    case none = -2
    
    var description: String {
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .backspace: return "⌫"
        case .none: return ""
        }
    }
}

struct NumPadRow: View {
    var keys: [NumPadKey]
    var action: (NumPadKey) -> Void
    
    var body: some View {
        HStack{
            ForEach(keys, id: \.self) { item in
                NumPadButton(key: item, action: self.action)
                    .padding(.leading, 6)
                    .padding(.trailing, item == keys.last ? 6 : 0)
            }
        }
    }
}

struct NumPadButton: View {
    var key: NumPadKey
    var action: (NumPadKey) -> Void
    
    var body: some View {
        Button {
            self.action(self.key)
        } label: {
            HStack(spacing: 0){
                Spacer()
                Text(key.description)
                    .font(key == .backspace ? .system(size: 28) : .system(size: 25))
                    .foregroundColor(.black)
                Spacer()
            }
            .frame(height: 46.0)
            .background(RoundedRectangle(cornerRadius: 5)
            .fill(key != .none && key != .backspace ? Color(red: 0.99, green: 0.99, blue: 1) : Color.clear )
            .shadow(color: Color(red: 0.54, green: 0.54, blue: 0.55), radius: 0, x: 0, y: 1))
        }
    }
}
