//
//  ContentView.swift
//  Shared
//
//  Created by Giga Khizanishvili on 05.02.22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: SetViewModel
    var body: some View {
        NavigationView {
            
            AspectVGrid(items: viewModel.cards, aspectRatio: 2/3) { card in
                CardView(card: card)
                    .padding(5)
                    .onTapGesture {
                        viewModel.select(card: card)
                    }
            }
            .padding(.horizontal)
            .navigationTitle("Set Game")
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarItems(
                leading:
                    Button("New Game") {
                        viewModel.startNewGame()
                    },
                trailing:
                    Button("Deal 3 More Cards") {
                        viewModel.dealMoreCards()
                    }
                    .disabled(viewModel.isDeckEmpty)
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .init())
    }
}
