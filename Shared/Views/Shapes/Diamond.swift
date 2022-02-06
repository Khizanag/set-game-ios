//
//  Diamond.swift
//  Set (iOS)
//
//  Created by Giga Khizanishvili on 05.02.22.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        let height: CGFloat = min(rect.height, rect.width/2) / CGFloat(2.0)
        let width: CGFloat = height * 2.0

        var path = Path()

        path.move   (to: .init(x: rect.midX,         y: rect.midY - height))
        path.addLine(to: .init(x: rect.midX + width, y: rect.midY         ))
        path.addLine(to: .init(x: rect.midX,         y: rect.midY + height))
        path.addLine(to: .init(x: rect.midX - width, y: rect.midY))
        path.addLine(to: .init(x: rect.midX,         y: rect.midY - height))
        
        return path
    }
}
