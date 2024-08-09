//
//  TwoScreensApp.swift
//  TwoScreens
//
//  Created by artyom s on 08.08.2024.
//

import SwiftUI

@main
struct TwoScreensApp: App {
    @StateObject var cart = Cart()

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
            ApplicationView(selectedLayout: .grid)
                .environmentObject(cart)
        }
    }
}
