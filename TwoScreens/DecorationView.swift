//
//  DecorationView.swift
//  TwoScreens
//
//  Created by artyom s on 09.08.2024.
//

import SwiftUI

struct DecorationView: View {
    var decorationText: String
    var color: Color
    
    var body: some View {
        Text(decorationText)
            .foregroundStyle(.white)
            .font(.system(size: 10))
            .padding(.leading, 12)
            .padding(.trailing, 6)
            .padding(.top, 2)
            .padding(.bottom, 4)
            .background(color)
            .lineLimit(1)
            .clipShape(
                RoundedCorner(radius: 25,
                              corners: [.topLeft, .topRight, .bottomRight]))

    }
}

