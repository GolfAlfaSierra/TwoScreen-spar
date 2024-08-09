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
    var imageDecoratorText = ""
    var imageDecoratorType = ItemDecorationType.none
    var discountValue = 0
    
    var isStarred = true
    
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

struct Cart {
    var items = [CartItem]()
    func addItem(id: UUID, amount: Double) {

        
    }
}

struct ViewModel {
    var selectedLayout = ItemsLayoutKind.list
    var items: [ItemModel] = mockData
}
