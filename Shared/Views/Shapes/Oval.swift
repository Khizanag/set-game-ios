//
//  Oval.swift
//  Set (iOS)
//
//  Created by Giga Khizanishvili on 05.02.22.
//

import SwiftUI

struct Oval: Shape {
    func path(in rect: CGRect) -> Path {
        let height: CGFloat = min(rect.height, rect.width/2)
        let width: CGFloat = height * 2

        return RoundedRectangle(cornerRadius: height/2)
            .path(in: .init(origin: .init(x: rect.midX - width/2, y: rect.midY - height/2),
                            size: .init(width: width, height: height)))
    }
}
