//
//  CartView.swift
//  TwoScreens
//
//  Created by artyom s on 09.08.2024.
//

import SwiftUI

struct AddCartView: View {
    @State var amountType = AmountType.kg
    @State var itemAmount = 0.0
    @EnvironmentObject var cart: Cart

    @Binding var viewModel: ItemModel

    private var minusButton: some View {
        Button {
            if amountType == .kg {
                let shouldCloseCart = cart.removeItem(id: viewModel.id, amount: 0.1)
                withAnimation {
                    viewModel.isAddedToCart = shouldCloseCart
                    itemAmount = cart.items.first(where: {$0.id == viewModel.id})?.amount ?? 0
                }

            } else {
                let shouldCloseCart = cart.removeItem(id: viewModel.id, amount: 1)
                withAnimation {
                    viewModel.isAddedToCart = shouldCloseCart
                    itemAmount = cart.items.first(where: {$0.id == viewModel.id})?.amount ?? 0
                }

            }
        } label: {
            Text("-")
                .foregroundStyle(.white)
                .font(.title).fontDesign(.rounded)
                .padding(.leading)
                .padding(.vertical, 4)
        }
    }

    private var plusButton: some View {
        Button {
            if amountType == .kg {
                cart.addItem(id: viewModel.id, amount: 0.1)
                withAnimation {
                    itemAmount = cart.items.first(where: {$0.id == viewModel.id})?.amount ?? 0
                }
            } else {
                cart.addItem(id: viewModel.id, amount: 1)
                withAnimation {
                    itemAmount = cart.items.first(where: {$0.id == viewModel.id})?.amount ?? 0
                }

            }
        } label: {
            Text("+")
                .foregroundStyle(.white)
                .font(.title).fontDesign(.rounded)
                .padding(.trailing)
                .padding(.vertical, 4)
        }
    }

    private var itemCart: some View {
        VStack(alignment: .leading) {
            Text("\(viewModel.price, specifier: "%.2f") р/кг")
                .font(.headline)
            Text("\(viewModel.previousPrice, specifier: "%.2f")")
                .font(.system(size: 12))
                .foregroundStyle(.secondary)
                .strikethrough()
        }.frame(maxWidth: .infinity, alignment: .leading)
        .overlay(alignment: .bottomTrailing) {

            Button {
                withAnimation {
                    viewModel.isAddedToCart = true
                    cart.addItem(id: viewModel.id, amount: 0.5)
                    itemAmount = cart.items.first(where: {$0.id == viewModel.id})?.amount ?? 0
                }
            } label: {
                Image(.cartIcon)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(.accent)
                    .clipShape(Capsule())
            }
        }.padding(.trailing, 4)
    }

    var body: some View {
        if viewModel.isAddedToCart {
            Picker("Amount type selection", selection: $amountType) {
                ForEach(AmountType.allCases) { option in
                    Text(String(describing: option))
                }
            }.pickerStyle(.segmented)
            HStack {
                minusButton
                Spacer()
                VStack {

                    Text("\(itemAmount, specifier: "%.2f") кг"  )
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
    }
}
