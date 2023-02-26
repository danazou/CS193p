//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Dana Zou on 16/10/2022.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject{ // our ViewModel, which is always a class; behave like an ObservableObject so it will publish changes
    private static let themes = MemoryGameTheme() // alternatively, define the individual themes here as an Array<Theme>
    
    static var emojiMemoryGameThemes: Array<MemoryGameTheme.Theme> = [themes.halloween, themes.gardening, themes.animals, themes.weather, themes.fruits, themes.food]
        
    static var currentTheme: MemoryGameTheme.Theme = emojiMemoryGameThemes.randomElement()!
    
    static func createMemoryGame(of theme: MemoryGameTheme.Theme) -> MemoryGame<String> {
        /*
         Function that creates a MemoryGame<String> and initialises it by defining a) numberOfPairOfCards and b) cardContent
         
         Input: theme
         Output: MemoryGame of type String with x pairs of cards, each pair of card has a unique emoji
         */
        var numberOfPairOfCards = theme.numberOfPairOfCards
        if numberOfPairOfCards > theme.emoji.count {
            numberOfPairOfCards = theme.emoji.count
        }
        
        let emojiUsedInGame = theme.emoji.shuffled()
        
        return MemoryGame<String> (numberOfPairOfCards: numberOfPairOfCards, emojiGameScore: 0) { pairIndex in
            emojiUsedInGame[pairIndex]
        }
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame(of: currentTheme)
    // private var means the View cannot see or change model, @Published so ViewModel will publish a change whenever model changes
    
    var cards: Array<MemoryGame<String>.Card> {
        // as model is private, in order for View to access the cards in the game, we need to create a var that returns an array of cards
        model.cards // returns an array of cards in the MemoryGame
    }
    
    var currentScore: Int {
        model.score
    }
    
    var colorOfCurrentTheme: Color? = nil
//    let colorFromTheme: String = currentTheme.color
    
    func determineThemeColor (themeColor: String) -> Color {
        switch themeColor {
        case "orange": return Color.orange
        case "blue": return Color.blue
        case "green": return Color.green
        case "pink": return Color.pink
        case "yellow": return Color.yellow
        case "purple": return Color.purple
        case "lime": return Color(red: 138/255, green: 229/255, blue: 118/255)
        default: return Color.gray
        }
    }
    
//    var score: Int = MemoryGame<String>.score
    
    // MARK: - Intent(s)
        /* "Mark: -" creates a bookmark section in the top nav bar
         Here we will create a function that registers user intent. In memorygame, the only user intent is to choose a card, i.e. translate a tap gesture -> choosing a card
         */
    
    func choose (_ card : MemoryGame<String>.Card) { // define external and internal label
        model.choose(card)
    }
    
    func newGame() {
        EmojiMemoryGame.currentTheme = EmojiMemoryGame.emojiMemoryGameThemes.randomElement()!
        colorOfCurrentTheme = determineThemeColor(themeColor: EmojiMemoryGame.currentTheme.color)
        model = EmojiMemoryGame.createMemoryGame(of: EmojiMemoryGame.currentTheme)
    }
}
