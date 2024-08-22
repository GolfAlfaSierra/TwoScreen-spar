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
    var isStarred = true

    var isAddedToCart = false
    var isFavorite = false
    var amountType = AmountType.kg
    var itemAmount = 0.00

    var score = 0.00
    var reviewCount = 0

    var description = ""
    var country = ""

    var price = 0.00
    var previousPrice = 0.00
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
    func removeItem(id: UUID, amount: Double) {
        guard  var item = items.first(where: {$0.id == id}) else {return }
        item.amount -= amount
        items.removeAll(where: {$0.id == item.id})
        items.append(item)

        if item.amount <= 0 {
            items.removeAll(where: {$0.id == item.id})
            return
        }
    }
}
