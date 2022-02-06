//
//  SetModel.swift
//  Set (iOS)
//
//  Created by Giga Khizanishvili on 05.02.22.
//

import Foundation

struct SetModel {
    // MARK: - Properties
    private(set) var cardsInDeck: [Card]
    private(set) var cardsOnTable: [Card]
    private var selectedCards: [Card]

    // MARK: - Static
    private static let initialCardsOnTableCount = 12
    private static let numCardsInSet = 3

    private static func getDeckOfCards() -> [Card] {
        var cards: [Card] = []

        Card.Shape.allCases.forEach { shape in
            Card.Color.allCases.forEach { color in
                Card.Shading.allCases.forEach { shading in
                    (1...numCardsInSet).forEach { numberOfShape in
                        cards.append(.init(id: cards.count, numberOfShapes: numberOfShape, shapeItem: .init(shape: shape, color: color, shading: shading)))
                    }
                }
            }
        }

        return cards
    }

    // MARK: - Init
    public init() {
        self.cardsInDeck  = Self.getDeckOfCards().shuffled()
        self.cardsOnTable = Array(cardsInDeck[0..<Self.initialCardsOnTableCount])
        self.cardsInDeck = Array(cardsInDeck[Self.initialCardsOnTableCount..<cardsInDeck.count])
        self.selectedCards = []
    }


    // MARK: - Public
    public mutating func dealMoreCards() {
        guard cardsInDeck.count >= Self.numCardsInSet else { return }
        if isSet(from: selectedCards) {
            replaceSelectionWithNewCardsFromDeck()
        } else {
            cardsInDeck[0..<Self.numCardsInSet].forEach { cardsOnTable.append($0) }
            cardsInDeck = Array(cardsInDeck[Self.numCardsInSet..<cardsInDeck.count])
        }
    }

    public mutating func reset() {
        self.cardsInDeck  = Self.getDeckOfCards().shuffled()
        self.cardsOnTable = Array(cardsInDeck[0..<Self.initialCardsOnTableCount])
        self.cardsInDeck = Array(cardsInDeck[Self.initialCardsOnTableCount..<cardsInDeck.count])
        self.selectedCards = []
    }

    public mutating func select(card: Card) {
        guard let index = cardsOnTable.firstIndex(where: { card.id == $0.id }) else { return }
        guard card.state != .selected else { deselectCard(on: index); return }
        let shouldSelectNewCard = !(isSet(from: selectedCards) && selectedCards.contains(where: { card.id == $0.id }))
        if selectedCards.count == Self.numCardsInSet { resetSetSelection() }
        if shouldSelectNewCard { selectNewCard(on: index) }
    }

    // MARK: - Private

    private mutating func selectNewCard(on index: Int) {
        cardsOnTable[index].state = .selected
        selectedCards.append(cardsOnTable[index])
        doSetDetection()
    }

    private mutating func deselectCard(on index: Int) {
        cardsOnTable[index].state = .nonTouched
        selectedCards.removeAll(where: { $0.id == cardsOnTable[index].id })
    }

    private mutating func resetSetSelection() {
        if isSet(from: selectedCards) { replaceSelectionWithNewCardsFromDeck() }
        clearSelection()
    }

    private mutating func replaceSelectionWithNewCardsFromDeck() {
        selectedCards.forEach { selectedCard in
            if let indexOfSelectedCard = cardsOnTable.firstIndex(where: { selectedCard.id == $0.id }) {
                if cardsInDeck.isEmpty {
                    cardsOnTable.remove(at: indexOfSelectedCard)
                } else {
                    cardsOnTable[indexOfSelectedCard] = cardsInDeck.removeLast()
                }
            }
        }
        selectedCards.removeAll()
    }

    private func isSet(from cards: [Card]) -> Bool {
        guard cards.count == Self.numCardsInSet else { return false }
        var colors: Set<Card.Color> = []
        var counts: Set<Int> = []
        var shadings: Set<Card.Shading> = []
        var shapes: Set<Card.Shape> = []
        cards.forEach { card in
            colors.insert(card.shapeItem.color)
            counts.insert(card.numberOfShapes)
            shadings.insert(card.shapeItem.shading)
            shapes.insert(card.shapeItem.shape)
        }

        return colors.count == Self.numCardsInSet
            && counts.count == Self.numCardsInSet
            && shadings.count == Self.numCardsInSet
            && shapes.count == Self.numCardsInSet
    }

    private mutating func doSetDetection() {
        guard selectedCards.count == Self.numCardsInSet else { return }
        let isSet = isSet(from: selectedCards)
        selectedCards.forEach { selectedCard in
            if let selectedCardIndex = cardsOnTable.firstIndex(where: { selectedCard.id == $0.id }) {
                cardsOnTable[selectedCardIndex].state = isSet ? .matched : .nonMatched
            }
        }
    }

    private mutating func clearSelection() {
        selectedCards.forEach { selectedCard in
            if let indexOfSelectedCard = cardsOnTable.firstIndex(where: { selectedCard.id == $0.id }) {
                cardsOnTable[indexOfSelectedCard].state = .nonTouched
            }
        }
        selectedCards.removeAll()
    }
}
