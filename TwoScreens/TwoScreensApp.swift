//
//  TwoScreensApp.swift
//  TwoScreens
//
//  Created by artyom s on 08.08.2024.
//

import SwiftUI

final class AppState: ObservableObject {
    @Published var selectedLayout = ItemsLayoutKind.list
    @Published var storeItems: [ItemModel] = mockData
    @Published var showSheet = false
}


@main
struct TwoScreensApp: App {
    @StateObject var cart = Cart()
    @StateObject var appState = AppState()
    
    init() {
        UISegmentedControl.appearance().setTitleTextAttributes([
            .foregroundColor: UIColor.label
        ], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([
            .foregroundColor: UIColor.secondaryLabel
        ], for: .normal)
    }

    var body: some Scene {
        WindowGroup {
            ApplicationView()
                .environmentObject(cart)
                .environmentObject(appState)
        }
    }
}
