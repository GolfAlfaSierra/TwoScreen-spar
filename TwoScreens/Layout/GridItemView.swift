//
//  GridItemView.swift
//  TwoScreens
//
//  Created by artyom s on 08.08.2024.
//

import SwiftUI

struct GridItemView: View {
    @Binding var model: ItemModel

    private var imageView: some View {
        model.image
            .overlay(alignment: .bottomTrailing) {
                if model.discountValue > 0 {
                    Text(model.discountValue, format: .percent)
                        .font(.headline).fontDesign(.rounded)
                        .foregroundStyle(.discountColorRed)
                        .padding(.trailing, 5)
                }

            }
            .overlay(alignment: .bottomLeading) {
                HStack(spacing: 2) {if model.isStarred {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                        .font(.system(size: 12))
                } else {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                        .font(.system(size: 12))
                        .opacity(0)
                }
                Text("\(model.score, specifier: "%.1f")")
                    .font(.system(size: 14))
                }
            }
    }

    var body: some View {
        VStack {
            imageView
            Text(model.description)
                .lineLimit(2)
                .font(.system(size: 12))
                .foregroundStyle(.secondary)
                .padding(2)
                .padding(.trailing, 12)
                .frame(maxHeight: .infinity)

            AddCartView(viewModel: $model) // cartview
        }

        .padding(6)
        .overlay(alignment: .topLeading) {
            let showDecoration = model.imageDecoratorText != "" || model.imageDecoratorType != .none
            if showDecoration {
                DecorationView(
                    decorationText: model.imageDecoratorText,
                    color: model.imageDecoratorType.color)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .background(RoundedRectangle(cornerRadius: 14).foregroundStyle(.white).shadow(color: .black.opacity(0.2), radius: 4))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .modifier(ActionListModifier(alignment: .topTrailing,
                                     background: .withBackground,
                                     isFavorite: $model.isFavorite))

    }
}

#Preview {
    @State var vm = ItemModel(description: "сыр Ламбер 500/0 230г")
    return GridItemView(model: $vm).frame(maxWidth: 168, maxHeight: 278)
}
