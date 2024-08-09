//
//  Models.swift
//  TwoScreens
//
//  Created by artyom s on 09.08.2024.
//

import SwiftUI

struct ItemModel: Identifiable {
    var id: UUID = UUID()
    var image = Image(.itemPlaceholder)
    var imageDecoratorText = "This is decorator!"
    var imageDecoratorType = ItemDecorationType.calm
    var discountValue = 1

    var isStarred = true
    
    var isAddedToCart = false
    var isFavorite = false
    
    var score = 4.5
    var reviewCount = 22

    var description = ""
    var country = ""
    var price = 0.00
    var previousPrice = 0.00
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

struct CartItem {
    var itemId: UUID
    var amount: Double
}

final class Cart: ObservableObject {
    var items = [CartItem]()
    func addItem(id: UUID, amount: Double) {
        if var item = items.first(where: {$0.itemId == id}) {
            items.removeAll(where: {$0.itemId == id})
            item.amount += amount
            items.append(item)
            return
        }
        items.append(
            CartItem(itemId: id, amount: amount)
        )

    }
    func removeItem(id: UUID, amount: Double) -> Bool {
        guard  var item = items.first(where: {$0.itemId == id}) else {return false}
        item.amount -= amount
        items.removeAll(where: {$0.itemId == item.itemId})
        items.append(item)

        if item.amount <= 0 {
            items.removeAll(where: {$0.itemId == item.itemId})
            return false
        }
        return true
    }
}

struct AppState {
    var selectedLayout = ItemsLayoutKind.list
    var items: [ItemModel] = mockData
}
