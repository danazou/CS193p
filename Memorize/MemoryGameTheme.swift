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
      
    // extra credit
    init(name: String, emojis: Array<String>, color: String) {
        self.name = name
        self.emojis = emojis
        self.numberOfPairOfCards = emojis.count
        self.color = color
    }
    
    init(name: String, emojis: Array<String>, numberOfPairOfCards: String, color: String) {
        self.name = name
        self.emojis = emojis
        self.numberOfPairOfCards = Array(0..<(emojis.count < 10 ? emojis.count : 10)).randomElement()!
        self.color = color
    }
    
}
