//
//  ContentView.swift
//  TwoScreens
//
//  Created by artyom s on 08.08.2024.
//

import SwiftUI

struct ApplicationView: View {
    @State var selectedLayout = ItemsLayoutKind.list
    var viewModel: ViewModel
    
    
    init(selectedLayout: ItemsLayoutKind = ItemsLayoutKind.list) {
        self.selectedLayout = selectedLayout
        self.viewModel = ViewModel()
    }
    
    var body: some View {
        NavigationStack {
            
            ScrollView {
                LazyVStack(alignment: .center, content: {
                    ForEach(viewModel.items) { item in
                        ListItem(model: item)
                    }
                    
                })
                .modifier(MakeToolBar(selectedLayout: $selectedLayout))
            }
        }
    }
}

struct MakeToolBar: ViewModifier {
    @Binding var selectedLayout: ItemsLayoutKind
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    
                    switch selectedLayout {
                    case .list:
                        Image(.cardListItemIcon)
                            .padding(10)
                            .background(.secondary.quinary)
                            .clipShape(RoundedCorner(radius: 12))
                            .onTapGesture {
                                // TODO animation does not work
                                withAnimation(.easeIn(duration: 1/8)) {
                                    selectedLayout = .grid
                                }
                                
                            }
                    case .grid:
                        Image(.cardGridItemIcon)
                            .padding(10)
                            .background(.secondary.quinary)
                            .clipShape(RoundedCorner(radius: 12))
                            .onTapGesture {
                                withAnimation(.easeIn(duration: 1/8)) {
                                    selectedLayout = .list
                                }
                            }
                        
                    }
                    
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.white, for: .navigationBar)
    }
}

#Preview {
    Text("Hello, world!")
        .modifier(MakeToolBar(selectedLayout: .constant(.list)))
}


#Preview {
    ApplicationView()
}
