//
//  ListItemCell.swift
//  TwoScreens
//
//  Created by artyom s on 08.08.2024.
//

import SwiftUI


struct ListItem: View {
    var model: ItemModel
    var body: some View {
        VStack {
            HStack {
                
                
                ListItemImage(viewModel: model                )
                ListItemContent(viewModel: model)
                
            }.padding(.bottom,16)
                .padding(.top,16)
                .padding(.leading,16)
                .padding(.trailing, 8)
            
            Divider()
            
        }
    }
}


private struct ListItemContent: View {
    var viewModel = ItemModel()
    @State var isAddedToCart = false

    init(viewModel: ItemModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            
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
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay() {
                VStack {
                    Button(action: {}, label: {
                        Image(.orderlistIcon)
                    })
                    
                    Button(action: {}, label: {
                        Image(.heartIcon)
                    })
                    
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 4)
                .padding(.top, 28)
                
            }
            VStack(alignment: .leading) {
                Text(viewModel.description)
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary)
                    .padding(2)
                    .padding(.trailing,12)
                    .frame(maxHeight: .infinity)
                
                Text("\(viewModel.country)")
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary.tertiary)
                Spacer()
                
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            CartView(isAddedToCart: $isAddedToCart, viewModel: viewModel)
            
        }
        
    }
}


struct CartView: View {
    @Binding var isAddedToCart: Bool
    @State var amountType = AmountType.kg
    var viewModel: ItemModel
    var body: some View {
        if isAddedToCart {
            Picker("Amount type selection", selection: $amountType) {
                ForEach(AmountType.allCases) { option in
                    Text(String(describing: option))
                }
            }.pickerStyle(.segmented)
            HStack {
                Button {
                    //TODO cart
                    if amountType == .kg {
                        //+0.1
                    }
                    if amountType == .piece {
                        //+1
                    }
                } label: {
                    Text("-")
                        .foregroundStyle(.white)
                        .font(.title).fontDesign(.rounded)
                        .padding(.leading)
                        .padding(.vertical, 4)
                }
                Spacer()
                VStack {
                    Text("0.1 кг")
                        .foregroundStyle(.white).font(.system(size: 16)).fontDesign(.rounded)
                    Text("~5,21")
                        .foregroundStyle(.white).opacity(0.5).font(.system(size: 12)).fontDesign(.rounded)
                }
                
                Spacer()
                Button {
                    if amountType == .kg {
                        //-0.1
                        // if count == 0 {isAddedToCart = false; return}
                    }
                    if amountType == .piece {
                        //-1
                        // if count == 0 {isAddedToCart = false; return}
                    }
                } label: {
                    Text("+")
                        .foregroundStyle(.white)
                        .font(.title).fontDesign(.rounded)
                        .padding(.trailing)
                        .padding(.vertical, 4)
                }
            }
            .frame(maxWidth: .infinity)
            .background(.accent)
            .clipShape(RoundedCorner(radius: 20))
        } else {
            
            
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
                            isAddedToCart.toggle()
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
    }
}

private struct ListItemImage: View {
    var viewModel: ItemModel
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
    return ApplicationView()
}
