//
//  GridItemView.swift
//  TwoScreens
//
//  Created by artyom s on 08.08.2024.
//

import SwiftUI

struct GridItemView: View {
    @Binding var model: ItemModel

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
            let showDecoration = model.image.imagedecorationText != "" || model.image.imagedecorationType != .none
            if showDecoration {
                DecorationView(
                    decorationText: model.image.imagedecorationText,
                    color: model.image.imagedecorationType.color)
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

private extension GridItemView {
    var imageView: some View {
        model.image.value
            .overlay(alignment: .bottomTrailing) {
                if model.image.discountValue > 0 {
                    Text(model.image.discountValue, format: .percent)
                        .font(.headline).fontDesign(.rounded)
                        .foregroundStyle(.discountColorRed)
                        .padding(.trailing, 5)
                }

            }
            .overlay(alignment: .bottomLeading) {
                HStack(spacing: 2) {
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
                    
                    if model.score > 0 {
                        Text("\(model.score)")
                            .font(.system(size: 14))
                    }
                }
            }
    }
}

#Preview {
    @State var vm = ItemModel(score: 0, description: "сыр Ламбер 500/0 230г")
    return GridItemView(model: $vm).frame(maxWidth: 168, maxHeight: 278).environmentObject(Cart())
}
