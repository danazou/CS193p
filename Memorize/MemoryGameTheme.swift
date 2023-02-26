//
//  MemoryGameTheme.swift
//  Memorize
//
//  Created by Dana Zou on 22/10/2022.
//

import Foundation

struct Theme{
    let name: String
    let emojis: Array<String>
    let numberOfPairOfCards: Int
    let color: String
    
    init(name: String, emojis: Array<String>, numberOfPairOfCards: Int, color: String) {
        self.name = name
        self.emojis = emojis
        self.numberOfPairOfCards = numberOfPairOfCards
        self.color = color
    }
    
}
