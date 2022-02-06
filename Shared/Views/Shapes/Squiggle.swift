//
//  Squiggle.swift
//  Set (iOS)
//
//  Created by Giga Khizanishvili on 05.02.22.
//

import SwiftUI

/// is replaced by rect for making life easier
struct Squiggle: Shape {
    func path(in rect: CGRect) -> Path {
        let height: CGFloat = min(rect.height, rect.width/2)
        let width: CGFloat = height * 2.0

        var path = Path()
        path.addRect(.init(
            x: rect.midX - width/2,
            y: rect.midY - height/2,
            width: width,
            height: height))
        return path
    }
}
