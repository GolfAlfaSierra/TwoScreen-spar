//
//  ListItemCell.swift
//  TwoScreens
//
//  Created by artyom s on 08.08.2024.
//

import SwiftUI

struct ListItemView: View {
    @State var itemModel: ItemModel
    var body: some View {
        VStack {
            HStack {
                ListItemImageView(viewModel: $itemModel)
                ListItemContentView(viewModel: $itemModel)

            }.padding(.bottom, 16)
            .padding(.top, 16)
            .padding(.leading, 16)
            .padding(.trailing, 8)

            Divider()

        }
    }
}

private struct ListItemContentView: View {
    @Binding var viewModel: ItemModel
    var body: some View {
        VStack {
            ReviewsView(viewModel: $viewModel)
                .frame(maxWidth: .infinity, alignment: .leading)
                .modifier(ActionListModifier(isFavorite: $viewModel.isFavorite))
            VStack(alignment: .leading) {
                Text(viewModel.description)
                    .lineLimit(2)
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary)
                    .padding(2)
                    .padding(.trailing, 12)
                    .frame(maxHeight: .infinity)

                Text("\(viewModel.country)")
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary.tertiary)
                Spacer()

            }
            .frame(maxWidth: .infinity, alignment: .leading)

            CartView(viewModel: $viewModel)

        }

    }
}

private struct ReviewsView: View {

   @Binding var viewModel: ItemModel
    var body: some View {
        HStack {
            if viewModel.isStarred {
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
            Text("| \(viewModel.reviewCount) отзывов")
                .font(.system(size: 14))
                .foregroundStyle(.secondary)

        }

    }
}

private struct ListItemImageView: View {
    @Binding var viewModel: ItemModel
    var body: some View {
        viewModel.image
            .overlay(alignment: .topLeading) {
                if viewModel.imageDecoratorText != "" || viewModel.imageDecoratorType != .none {
                    DecorationView(decorationText: viewModel.imageDecoratorText, color: viewModel.imageDecoratorType.color)
                }
            }
            .overlay(alignment: .bottomTrailing) {
                if viewModel.discountValue > 0 {
                    Text(viewModel.discountValue, format: .percent)
                        .font(.headline).fontDesign(.rounded)
                        .foregroundStyle(.discountColorRed)
                        .padding(.trailing, 5)
                }

            }
    }
}

#Preview {
    return ApplicationView(appState: .init(selectedLayout: .grid))
}
