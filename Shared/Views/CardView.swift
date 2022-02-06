//
//  CardView.swift
//  Set (iOS)
//
//  Created by Giga Khizanishvili on 05.02.22.
//

import SwiftUI

struct CardView: View {
    let card: Card
    
    var body: some View {
        let cardShapeItemsData: [Card.ShapeItem] = (0..<card.numberOfShapes).map { id in
                .init(shape: card.shapeItem.shape, color: card.shapeItem.color, shading: card.shapeItem.shading, id: id)
        }

        ZStack {
            VStack {
                ForEach(cardShapeItemsData) { shapeItem in
                    ShapeView(shapeItem: shapeItem)
                }
            }
            .padding()
            .shadow(color: .gray, radius: 2, x: 0, y: 2)

            RoundedRectangle(cornerRadius: 10)
                .stroke(card.state.statusColor, lineWidth: 3)
                .opacity(0.5)
        }
    }
    
    struct ShapeView: View {
        let shapeItem: Card.ShapeItem
        
        var body: some View {
            GeometryReader { geometry in
                let shape = shapeItem.shape.getPath(in: geometry.frame(in: .local))

                ZStack {
                    switch shapeItem.shading {
                    case .solid:
                        shape
                            .fill(shapeItem.color.value)
                        shape
                            .stroke(shapeItem.color.value)
                    case .open:
                        shape
                            .stroke(shapeItem.color.value)
                    case .striped:
                        shape
                            .fill(shapeItem.color.value)
                            .opacity(0.25)
                        shape
                            .stroke(shapeItem.color.value)
                    }
                }
            }
        }
    }
}

fileprivate extension Card.Color {
    var value: Color {
        switch self {
        case .red:    return .red
        case .green:  return .green
        case .purple: return .purple
        }
    }
}

fileprivate extension Card.Shape {
    func getPath(in rect: CGRect) -> Path {
        switch self {
        case .diamond:  return Diamond().path(in: rect)
        case .oval:     return Oval().path(in: rect)
        case .squiggle: return Squiggle().path(in: rect)
        }
    }
}

fileprivate extension Card.State {
    var statusColor: Color {
        switch self {
        case .nonTouched: return .gray
        case .matched:    return .green
        case .nonMatched: return .red
        case .selected:   return .yellow
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: .init(id: 0, numberOfShapes: 3, shapeItem: .init(shape: .diamond, color: .green, shading: .solid)))
    }
}
