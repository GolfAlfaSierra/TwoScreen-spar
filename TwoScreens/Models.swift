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

struct CartItem: Identifiable {
    var id: UUID
    var amount: Double
    var descripiton = ""
    var price = 0
    var previousPrice = 0
    var image = Image(.itemPlaceholder)
}

final class Cart: ObservableObject {
    var items = [CartItem]()
    func addItem(id: UUID, amount: Double) {
        if var item = items.first(where: {$0.id == id}) {
            items.removeAll(where: {$0.id == id})
            item.amount += amount
            items.append(item)
            return
        }
        items.append(
            CartItem(id: id, amount: amount)
        )

    }
    func removeItem(id: UUID, amount: Double) -> Bool {
        guard  var item = items.first(where: {$0.id == id}) else {return false}
        item.amount -= amount
        items.removeAll(where: {$0.id == item.id})
        items.append(item)

        if item.amount <= 0 {
            items.removeAll(where: {$0.id == item.id})
            return false
        }
        return true
    }
}

final class AppState: ObservableObject {
    @Published var selectedLayout = ItemsLayoutKind.list
    @Published var items: [ItemModel] = mockData
}
