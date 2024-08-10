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
            if model.isStarred {
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
            Text("| \(model.reviewCount) отзывов")
                .font(.system(size: 14))
                .foregroundStyle(.secondary)

        }
    }
    
    private var imageView: some View {
        model.image
            .overlay(alignment: .topLeading) {
                if model.imageDecoratorText != "" || model.imageDecoratorType != .none {
                    DecorationView(decorationText: model.imageDecoratorText, color: model.imageDecoratorType.color)
                }
            }
            .overlay(alignment: .bottomTrailing) {
                if model.discountValue > 0 {
                    Text(model.discountValue, format: .percent)
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
    return ApplicationView(appState: .init(selectedLayout: .grid))
}
