//
//  GridItemView.swift
//  TwoScreens
//
//  Created by artyom s on 08.08.2024.
//

import SwiftUI

struct GridItemView: View {
    @State var viewModel: ItemModel
    var body: some View {
        VStack {

            viewModel.image
                .overlay(alignment: .bottomTrailing) {
                    if viewModel.discountValue > 0 {
                        Text(viewModel.discountValue, format: .percent)
                            .font(.headline).fontDesign(.rounded)
                            .foregroundStyle(.discountColorRed)
                            .padding(.trailing, 5)
                    }

                }

            Text(viewModel.description)
                .lineLimit(2)
                .font(.system(size: 12))
                .foregroundStyle(.secondary)
                .padding(2)
                .padding(.trailing, 12)
                .frame(maxHeight: .infinity)

            CartView(viewModel: $viewModel) // cartview
        }

        .padding(6)
        .overlay(alignment: .topLeading) {
            if viewModel.imageDecoratorText != "" ||
                viewModel.imageDecoratorType != .none {
                DecorationView(
                    decorationText: viewModel.imageDecoratorText,
                    color: viewModel.imageDecoratorType.color)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .background(RoundedRectangle(cornerRadius: 14).foregroundStyle(.white).shadow(color: .black.opacity(0.2), radius: 4))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .modifier(ActionListModifier(alignment: .topTrailing,
                                     background: .withBackground,
                                     isFavorite: $viewModel.isFavorite))

    }
}

#Preview {
    GridItemView(viewModel: ItemModel(description: "сыр Ламбер 500/0 230г")).frame(maxWidth: 168, maxHeight: 278)
}
