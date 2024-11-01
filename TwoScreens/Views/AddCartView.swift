//
//  CartView.swift
//  TwoScreens
//
//  Created by artyom s on 09.08.2024.
//

import SwiftUI

struct AddCartView: View {
    @EnvironmentObject var cart: Cart
    @Binding var viewModel: ItemModel
    private var previousPrice: String {
        viewModel.price.formatted(.number.precision(.fractionLength(2...)))
    }
    
    private var itemAmount: String {
        viewModel.itemAmount.formatted(.number.precision(.fractionLength(2...)))
    }
    
    var body: some View {
        Group {
            if viewModel.isAddedToCart {
                Picker("Amount type selection", selection: $viewModel.amountType) {
                    ForEach(AmountType.allCases) { option in
                        Text(String(describing: option))
                    }
                }.pickerStyle(.segmented)
                HStack {
                    minusButton
                    Spacer()
                    VStack {
                        let countText = viewModel.amountType == .kg ? "кг" : "шт"

                        Text("\(itemAmount) \(countText)"  )
                            .foregroundStyle(.white).font(.system(size: 16)).fontDesign(.rounded)
                        Text("~5,21")
                            .foregroundStyle(.white).opacity(0.5).font(.system(size: 12)).fontDesign(.rounded)
                    }

                    Spacer()
                    plusButton
                }
                .frame(maxWidth: .infinity)
                .background(.accent)
                .clipShape(RoundedCorner(radius: 20))
            } else {
                itemCart
            }
        }.onAppear {
            viewModel.itemAmount = cart.items.first(where: {$0.id == viewModel.id})?.amount ?? 0.1
        }
        .onChange(of: viewModel.itemAmount) { _, newValue in
            if newValue <= 0 {
                withAnimation {
                    viewModel.isAddedToCart = false
                }
            }
        }
    }
}

private extension AddCartView {
    private var itemCart: some View {
        HStack {
            let countText = viewModel.amountType == .kg ? "р/кг" : "шт"
            VStack(alignment: .leading) {
                Text("\(previousPrice) \(countText)")
                    .font(.headline)
                if viewModel.price > 0 {
                    Text("\(previousPrice)")
                        .font(.system(size: 12))
                        .foregroundStyle(.secondary)
                        .strikethrough()
                }
            }
            Spacer()
            Button {
                withAnimation {
                    viewModel.isAddedToCart = true
                    cart.addItem(id: viewModel.id, amount: 0.1)
                    viewModel.itemAmount = cart.items.first(where: {$0.id == viewModel.id})?.amount ?? 0
                }
            } label: {
                Image(.cartIcon)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(.accent)
                    .clipShape(Capsule())
            }
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var minusButton: some View {
        Button {
            withAnimation {
            viewModel.amountType == .kg ?
                cart.removeItem(id: viewModel.id, amount: 0.1) :
                cart.removeItem(id: viewModel.id, amount: 1)
                viewModel.itemAmount = cart.items.first(where: {$0.id == viewModel.id})?.amount ?? 0
            }

        } label: {
            Text("-")
                .foregroundStyle(.white)
                .font(.title).fontDesign(.rounded)
                .padding(.leading)
                .padding(.vertical, 4)
        }
    }

    var plusButton: some View {
        Button {
            withAnimation {
            viewModel.amountType == .kg ?
                cart.addItem(id: viewModel.id, amount: 0.1) :
                cart.addItem(id: viewModel.id, amount: 1)
                viewModel.itemAmount = cart.items.first(where: {$0.id == viewModel.id})?.amount ?? 0
            }
        }
        label: {
            Text("+")
                .foregroundStyle(.white)
                .font(.title).fontDesign(.rounded)
                .padding(.trailing)
                .padding(.vertical, 4)
        }
    }

}

#Preview {
    @EnvironmentObject var cart: Cart

    return  HStack {
        AddCartView(
            cart: _cart,
            viewModel: .constant(.init())).environmentObject(Cart())
    }
}
