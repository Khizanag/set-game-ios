//
//  Card.swift
//  Set (iOS)
//
//  Created by Giga Khizanishvili on 05.02.22.
//

import Foundation

struct Card: Identifiable {
    let id: Int
    let numberOfShapes: Int
    let shapeItem: ShapeItem
    var state: Card.State = .nonTouched
    
    struct ShapeItem: Identifiable {
        let id: Int
        let shape: Card.Shape
        let color: Card.Color
        let shading: Card.Shading
        
        init(shape: Card.Shape, color: Card.Color, shading: Card.Shading, id: Int = 0) {
            self.shape = shape
            self.color = color
            self.shading = shading
            self.id = id
        }
    }

    enum Color: CaseIterable {
        case red
        case green
        case purple
    }

    enum Shape: CaseIterable {
        case diamond
        case squiggle
        case oval
    }

    enum Shading: CaseIterable {
        case solid
        case striped
        case open
    }

    enum State {
        case matched
        case nonMatched
        case nonTouched
        case selected
    }
}
