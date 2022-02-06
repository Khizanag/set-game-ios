//
//  SetApp.swift
//  Shared
//
//  Created by Giga Khizanishvili on 05.02.22.
//

import SwiftUI

@main
struct SetApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: .init())
        }
    }
}

// TODO: As the game play progresses, try to keep all the cards visible and as large as possible

