//
//  MemoryGameTheme.swift
//  Memorize
//
//  Created by Dana Zou on 22/10/2022.
//

import Foundation

struct MemoryGameTheme {
    
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
    
    // below themes should live in ViewModel
    let halloween = Theme(name: "Halloween", emoji: ["🎃", "👻", "🍬", "🏚️","🧛", "🦇", "🧟", "🕸️", "🕷️" ], numberOfPairOfCards: 4, color: "orange")

    let gardening = Theme(name: "Gardening", emoji: ["🪴", "🍁", "🍄", "🥬", "🌽", "🫑", "🍠", "🌾", "🌻", "🌱", "🧑‍🌾", "🍅", "🥕", "🥦"], numberOfPairOfCards: 7, color: "green")
    
    let animals = Theme(name: "Animals", emoji: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵", "🐔", "🐧", "🐦", "🦅", "🦉", "🐙", "🐳", "🐁"], numberOfPairOfCards: 5, color: "pink")
    
    let weather = Theme(name: "Weather", emoji: ["🌞", "🌝", "🌤", "⛅️", "🌥", "☁️", "🌦", "🌧", "⛈", "🌩", "🌨", "☃️", "🌬", "☔️", "🌫", "❄️", "🌪", "⚡️", "🌚", "🌙", "🌛", "🌜", "🌑", "🌕"], numberOfPairOfCards: 8, color: "yellow")
    
    let fruits = Theme(name: "Fruits", emoji: ["🍒","🍓", "🍇", "🍎", "🍉", "🍑", "🍊", "🍋", "🍌", "🍏", "🍈", "🍐", "🥝", "🥭", "🥥", "🫐"], numberOfPairOfCards: 6, color: "lime")
    
    let food = Theme(name: "Food", emoji: ["🥘", "🍲", "🍛", "🍜", "🍤", "🥟", "🍦", "🥞", "🍪", "🥨", "🥮", "🍢", "🥐", "🫕", "🫔", "🦪", "🍙", "🍘", "🥪", "🥧"], numberOfPairOfCards: 3, color: "purple")
    
    
}
