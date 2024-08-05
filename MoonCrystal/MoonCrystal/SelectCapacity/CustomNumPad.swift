//
//  CustomNumpad.swift
//  MoonCrystal
//
//  Created by seonu kim on 8/5/24.
//

import SwiftUI

struct CustomNumPad : View {
    @Binding var string : String
    let maxDigits : Int = 18
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 6) {
                NumPadRow(keys: ["1", "2", "3"], action: keyWasPressed(_:))
                NumPadRow(keys: ["4", "5", "6"], action: keyWasPressed(_:))
                NumPadRow(keys: ["7", "8", "9"], action: keyWasPressed(_:))
                NumPadRow(keys: ["", "0", "⌫"], action: keyWasPressed(_:))
            }
            .padding(.top, 6)
            Spacer()
        }
        .frame(height: 291.0)
        .background(Color(red: 0.81, green: 0.82, blue: 0.84))
    }
    
    private func keyWasPressed(_ key: String) {
        if ( string.trimmingCharacters(in: .whitespacesAndNewlines).count > maxDigits-1 && key != "⌫" ) {
            print("❌ Over the max digit for Int64 \(string.count) ")
            return
        }
        switch key {
        case "⌫":
            if string.isEmpty { string = "0" } else {
                string.removeLast()
            }
            if string.isEmpty { string = "0" }
        case "" : return
        case _ where string == "0": string = key
        default: string += key
        }
    }
}

struct NumPadRow: View {
    var keys: [String]
    var action : (String) -> Void
    
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
    var key : String
    var action : (String) -> Void
    
    var body: some View {
        Button {
            self.action(self.key)
        } label : {
            HStack(spacing: 0){
                Spacer()
                Text(key)
                    .font(key == "⌫" ? .system(size: 28) : .system(size: 25) )
                    .foregroundColor(.black)
                Spacer()
            }.frame(height: 46.0)
                .accessibilityIdentifier("keyPadButton\(self.key)")
                .background(RoundedRectangle(cornerRadius: 5)
                    .fill(key != "" && key != "⌫" ? Color(red: 0.99, green: 0.99, blue: 1) : Color.clear )
                    .shadow(color: Color(red: 0.54, green: 0.54, blue: 0.55), radius: 0, x: 0, y: 1)
                )
        }
    }
}
