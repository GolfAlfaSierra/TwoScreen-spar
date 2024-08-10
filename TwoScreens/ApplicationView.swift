//
//  ContentView.swift
//  TwoScreens
//
//  Created by artyom s on 08.08.2024.
//

import SwiftUI

struct ApplicationView: View {
    @State var appState = AppState()

    var body: some View {
        NavigationStack {

            ScrollView {
                switch appState.selectedLayout {
                case .list:
                    LazyVStack(alignment: .center, content: {
                        ForEach($appState.items) { item in

                            ListItemView(itemModel: item)
                        }

                    })
                    .modifier(MakeToolBarModifier(selectedLayout: $appState.selectedLayout))
                case .grid:
                    let columns = [
                        GridItem(.flexible(minimum: 0, maximum: .infinity)),
                        GridItem(.flexible(minimum: 0, maximum: .infinity))
                    ]

                    LazyVGrid(columns: columns) {
                        ForEach($appState.items) {item in
                            GridItemView(viewModel: item)

                        }
                    }.padding()
                    .modifier(MakeToolBarModifier(selectedLayout: $appState.selectedLayout))
                }

            }
        }
    }
}

#Preview {
    ApplicationView()
}
