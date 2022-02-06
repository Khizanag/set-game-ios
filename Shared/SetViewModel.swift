//
//  SetViewModel.swift
//  Set (iOS)
//
//  Created by Giga Khizanishvili on 05.02.22.
//

import Foundation

class SetViewModel: ObservableObject {
    // MARK: - Properties
    @Published private var model: SetModel = .init()

    // MARK: - Public
    public var cards: [Card] {
        model.cardsOnTable
    }
    
    public var isDeckEmpty: Bool {
        model.cardsInDeck.isEmpty
    }

    public func startNewGame() {
        model.reset()
    }

    public func dealMoreCards() {
        model.dealMoreCards()
    }

    public func select(card: Card) {
        model.select(card: card)
    }
}
