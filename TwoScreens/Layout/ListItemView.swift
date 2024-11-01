//
//  ListItemCell.swift
//  TwoScreens
//
//  Created by artyom s on 08.08.2024.
//

import SwiftUI

struct ListItemView: View {
    @Binding var model: ItemModel

    private var contentView: some View {
        VStack {
            reviewsView
                .frame(maxWidth: .infinity, alignment: .leading)
                .modifier(ActionListModifier(isFavorite: $model.isFavorite))
            VStack(alignment: .leading) {
                Text(model.description)
                    .lineLimit(2)
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary)
                    .padding(2)
                    .padding(.trailing, 12)
                    .frame(maxHeight: .infinity)

                Text("\(model.country)")
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary.tertiary)
                Spacer()

            }
            .frame(maxWidth: .infinity, alignment: .leading)

            AddCartView(viewModel: $model)

        }
    }

    private var reviewsView: some View {
        HStack {
            if model.score > 0 {
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
                    .font(.system(size: 12))
            } else {
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
                    .font(.system(size: 12))
                    .opacity(0)
            }
            Text("\(model.score.formatted(.number.precision(.fractionLength(1...))))")
                .font(.system(size: 14))
            Text("| \(model.reviewCount) отзывов")
                .font(.system(size: 14))
                .foregroundStyle(.secondary)

        }
    }

    private var imageView: some View {
        model.image.value
            .overlay(alignment: .topLeading) {
                let showDecoration = model.image.imagedecorationText != "" || model.image.imagedecorationType != .none
                if showDecoration {
                    DecorationView(decorationText: model.image.imagedecorationText, color: model.image.imagedecorationType.color)
                }
            }
            .overlay(alignment: .bottomTrailing) {
                let hasDiscount = model.image.discountValue > 0
                if hasDiscount {
                    Text(model.image.discountValue, format: .percent)
                        .font(.headline).fontDesign(.rounded)
                        .foregroundStyle(.discountColorRed)
                        .padding(.trailing, 5)
                }

            }
    }

    var body: some View {
        VStack {
            HStack {
                imageView
                contentView

            }.padding(.bottom, 16)
            .padding(.top, 16)
            .padding(.leading, 16)
            .padding(.trailing, 8)

            Divider()

        }
    }
}

#Preview {
    return ApplicationView().environmentObject(AppState()).environmentObject(Cart())
}
