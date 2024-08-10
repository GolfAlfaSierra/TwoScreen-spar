//
//  GridItemView.swift
//  TwoScreens
//
//  Created by artyom s on 08.08.2024.
//

import SwiftUI

struct GridItemView: View {
    @Binding var viewModel: ItemModel
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
                .overlay(alignment: .bottomLeading) {
                    HStack(spacing: 2) {if viewModel.isStarred {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                            .font(.system(size: 12))
                    } else {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                            .font(.system(size: 12))
                            .opacity(0)
                    }
                    Text("\(viewModel.score, specifier: "%.1f")")
                        .font(.system(size: 14))
                    }
                }

            Text(viewModel.description)
                .lineLimit(2)
                .font(.system(size: 12))
                .foregroundStyle(.secondary)
                .padding(2)
                .padding(.trailing, 12)
                .frame(maxHeight: .infinity)

            AddCartView(viewModel: $viewModel) // cartview
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
    @State var vm = ItemModel(description: "сыр Ламбер 500/0 230г")
    return GridItemView(viewModel: $vm).frame(maxWidth: 168, maxHeight: 278)
}
