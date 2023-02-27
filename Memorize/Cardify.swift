//
//  Cardify.swift
//  Memorize
//
//  Created by Dana Zou on 26/02/2023.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 180 : 0
    }
    
    var rotation: Double
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            
            if rotation > 90 {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            }
            else {
                shape.fill()
            }
            content.opacity(rotation > 90 ? 1 : 0)
        }
        .rotation3DEffect(.degrees(rotation), axis: (0, 1, 0))
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 8
        static let lineWidth: CGFloat = 3
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}

