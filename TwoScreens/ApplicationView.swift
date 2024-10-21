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
                    listLayout
                case .grid:
                    gridLayout                }

            }.overlay(alignment: .bottomTrailing) {
                cartButton            }
            .sheet(isPresented: $appState.showSheet) {
                CartListView()
            }
        }
    }
}

private extension ApplicationView {
    
    var gridLayout: some View {
        let columns = [
            GridItem(.flexible(minimum: 0, maximum: .infinity)),
            GridItem(.flexible(minimum: 0, maximum: .infinity))
        ]

        return LazyVGrid(columns: columns) {
            ForEach($appState.storeItems) {item in
                GridItemView(model: item)

            }
        }.padding()
        .modifier(MakeToolBarModifier(selectedLayout: $appState.selectedLayout))

    }
    
    var listLayout: some View {
        LazyVStack(alignment: .center, content: {
            ForEach($appState.storeItems) { item in

                ListItemView(model: item)
            }

        })
        .modifier(MakeToolBarModifier(selectedLayout: $appState.selectedLayout))
    }
    
    var cartButton: some View {
        Button {
            appState.showSheet.toggle()
        } label: {
            Image(.cartIcon)
                .scaleEffect(CGSize(width: 1.2, height: 1.2))
                .padding(8*2.5)
                .background(.green)
                .clipShape(Circle())
                .offset(x: -16)
        }
    }
}

#Preview {
    ApplicationView().environmentObject(AppState()).environmentObject(Cart())
}
