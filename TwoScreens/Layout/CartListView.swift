//
//  CartView.swift
//  TwoScreens
//
//  Created by artyom s on 11.08.2024.
//

import SwiftUI

struct CartListView: View {
    @EnvironmentObject var cart: Cart
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .center, content: {
                    ForEach($cart.items) { item in
                        let item = $appState.storeItems.first(where: {$0.id == item.id})!
                        
                        CartItemView(model: item)
                        
                    }
                    
                })
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "xmark")
                        .foregroundStyle(.accent)
                        .onTapGesture {
                            dismiss()
                        }
                }
            }
            .navigationTitle("Cart items")
            .navigationBarTitleDisplayMode(.inline)
        }

    }
}

struct CartItemView: View {
    @Binding var model: ItemModel

    var imageView: some View {
        model.image.value
            .overlay(alignment: .topLeading) {
                if model.image.imagedecorationText != "" || model.image.imagedecorationType != .none {
                    DecorationView(decorationText: model.image.imagedecorationText, color: model.image.imagedecorationType.color)
                }
            }
            .overlay(alignment: .bottomTrailing) {
                if model.image.discountValue > 0 {
                    Text(model.image.discountValue, format: .percent)
                        .font(.headline).fontDesign(.rounded)
                        .foregroundStyle(.discountColorRed)
                        .padding(.trailing, 5)
                }

            }
    }

    var body: some View {
        HStack {
            imageView
            VStack {
                Spacer()
                AddCartView(viewModel: $model)
            }
        }
        .padding()
    }

}

#Preview {
    let cart = Cart()
    let appState = AppState()

    cart.addItem(id: appState.storeItems[0].id, amount: 0)
    cart.addItem(id: appState.storeItems[1].id, amount: 10)
    return CartListView().environmentObject(cart).environmentObject(appState)
}
