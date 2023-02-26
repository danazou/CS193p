//
//  MemoryGameTheme.swift
//  Memorize
//
//  Created by Dana Zou on 22/10/2022.
//

import Foundation
    
struct Theme{
    let name: String
    let emoji: Array<String>
    let numberOfPairOfCards: Int
    let color: String
    
    init(name: String, emoji: Array<String>, numberOfPairOfCards: Int, color: String) {
        self.name = name
        self.emoji = emoji
        self.numberOfPairOfCards = numberOfPairOfCards
        self.color = color
    }
}
    
    
