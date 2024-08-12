//
//  ContentView.swift
//  TwoScreens
//
//  Created by artyom s on 08.08.2024.
//

import SwiftUI

struct ApplicationView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationStack {

            ScrollView {
                switch appState.selectedLayout {
                case .list:
                    LazyVStack(alignment: .center, content: {
                        ForEach($appState.storeItems) { item in

                            ListItemView(model: item)
                        }

                    })
                    .modifier(MakeToolBarModifier(selectedLayout: $appState.selectedLayout))
                case .grid:
                    let columns = [
                        GridItem(.flexible(minimum: 0, maximum: .infinity)),
                        GridItem(.flexible(minimum: 0, maximum: .infinity))
                    ]

                    LazyVGrid(columns: columns) {
                        ForEach($appState.storeItems) {item in
                            GridItemView(model: item)

                        }
                    }.padding()
                    .modifier(MakeToolBarModifier(selectedLayout: $appState.selectedLayout))
                }

            }
        }
    }
}

#Preview {
    ApplicationView().environmentObject(AppState()).environmentObject(Cart())
}
