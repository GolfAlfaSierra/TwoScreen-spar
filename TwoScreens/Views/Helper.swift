//
//  Helper.swift
//  TwoScreens
//
//  Created by artyom s on 08.08.2024.
//

import SwiftUI

struct RoundedCorner: Shape {
    let radius: CGFloat
    let corners: UIRectCorner

    init(radius: CGFloat = .infinity, corners: UIRectCorner = .allCorners) {
        self.radius = radius
        self.corners = corners
    }

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct ActionListModifier: ViewModifier {
    enum ActionListType {
        case standart, withBackground
    }

    var alignment: Alignment = .center
    var background: ActionListType = .standart
    
    @Binding var isFavorite: Bool

    func body(content: Content) -> some View {
        content
            .overlay(alignment: alignment) {
                VStack {
                    Button(action: {}, label: {
                        Image(.orderlistIcon)
                    })

                    Button(action: {isFavorite.toggle()}, label: {
                        if !isFavorite {Image(.heartIcon)} else {Image(.hearticonfill)}
                        
                    })

                }
                .background {
                    if background == .withBackground {
                        RoundedCorner(radius: 16, corners: .bottomLeft).fill(.white).opacity(0.8)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(6)

            }
    }
}

struct MakeToolBarModifier: ViewModifier {
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
                            .clipShape(RoundedRectangle(cornerRadius: 12))
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
                            .clipShape(RoundedRectangle(cornerRadius: 12))
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
