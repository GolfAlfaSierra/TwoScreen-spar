//
//  ContentView.swift
//  TwoScreens
//
//  Created by artyom s on 08.08.2024.
//

import SwiftUI

struct ApplicationView: View {
    @State var selectedLayout = ItemsLayoutKind.grid
    var appState = AppState()

    var body: some View {
        NavigationStack {

            ScrollView {
                switch selectedLayout {
                case .list:
                    LazyVStack(alignment: .center, content: {
                        ForEach(appState.items) { item in
                            ListItemView(model: item)
                        }

                    })
                    .modifier(MakeToolBarModifier(selectedLayout: $selectedLayout))
                case .grid:
                    let columns = [
                        GridItem(.flexible(minimum: 0, maximum: .infinity)),
                        GridItem(.flexible(minimum: 0, maximum: .infinity))
                    ]

                    LazyVGrid(columns: columns) {
                        ForEach(appState.items) {item in
                            GridItemView(viewModel: item)

                        }
                    }.padding()
                    .modifier(MakeToolBarModifier(selectedLayout: $selectedLayout))
                }

            }
        }
    }
}

#Preview {
    ApplicationView(selectedLayout: .grid, appState: AppState())
}
