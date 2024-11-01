//
//  Models.swift
//  TwoScreens
//
//  Created by artyom s on 09.08.2024.
//

import SwiftUI

struct ItemModel: Identifiable {
    var id: UUID = UUID()
    var image = Image()
//    var isStarred = true
    
    var isAddedToCart = false
    var isFavorite = false
    var amountType = AmountType.kg
    var itemAmount: Decimal = 0.00
    
    var score: Decimal = 0.00
    var reviewCount: Decimal = 0
    
    var description = ""
    var country = ""
    
    var discountedPrice: Decimal = 0.00
    var price: Decimal = 0.00
}

extension ItemModel {
    struct Image {
        var value = SwiftUI.Image(.itemPlaceholder)
        var imagedecorationText = "This is decorator!"
        var imagedecorationType = ItemDecorationType.calm
        var discountValue = 1
    }
}

enum ItemDecorationType {
    case none, agressive, neutral, calm
    
    var color: Color {
        switch self {
        case .none:
                .clear
        case .agressive:
                .cellLabelDecorationAgressive
        case .neutral:
                .cellLabelDecorationNeutral
        case .calm:
                .cellLabelDecorationCalm
        }
    }
}

enum AmountType: Identifiable, CaseIterable, CustomStringConvertible {
    var id: Self {self}
    
    var description: String {
        switch self {
        case .piece:
            "Шт"
        case .kg:
            "Кг"
        }
    }
    case  piece, kg
}

enum ItemsLayoutKind {
    case list, grid
}

final class Cart: ObservableObject {
    @Published var items = [CartItem]()
    
    func addItem(id: UUID, amount: Decimal) {
        if let index = items.firstIndex(where: {$0.id == id}) {
            items[index].amount += amount
            return
        } else {
            items.append(
                CartItem(id: id, amount: amount)
            )
        }
    }
    func removeItem(id: UUID, amount: Decimal) {
        if let index = items.firstIndex(where: {$0.id == id}) {
            items[index].amount -= amount
            if items[index].amount <= 0 {
                items.remove(at: index)
            }
        }
        
    }
}
