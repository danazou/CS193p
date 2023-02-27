//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Dana Zou on 16/10/2022.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject{ // our ViewModel, which is always a class; behave like an ObservableObject so it will publish changes
    typealias Card = MemoryGame<String>.Card
    
    init(){
        currentTheme = themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(of: currentTheme)
    }
 
    var currentTheme: Theme
    
    static func createMemoryGame(of theme: Theme) -> MemoryGame<String> {
        /*
         Function that creates a MemoryGame<String> and initialises it by defining a) numberOfPairOfCards and b) cardContent
         
         Input: theme
         Output: MemoryGame of type String with x pairs of cards, each pair of card has a unique emoji
         */
        var numberOfPairOfCards = theme.numberOfPairOfCards
        if numberOfPairOfCards > theme.emojis.count {
            numberOfPairOfCards = theme.emojis.count
        }
        
        let emojisUsedInGame = theme.emojis.shuffled()
        
        return MemoryGame<String> (numberOfPairOfCards: numberOfPairOfCards, emojiGameScore: 0) { pairIndex in
            emojisUsedInGame[pairIndex]
        }
    }
    
    private let themes: Array<Theme> = [
        Theme(name: "Halloween", emojis: ["🎃", "👻", "🍬", "🏚️","🧛", "🦇", "🧟", "🕸️", "🕷️" ], numberOfPairOfCards: 4, color: "orange"),
        Theme(name: "Gardening", emojis: ["🪴", "🍁", "🍄", "🥬", "🌽", "🫑", "🍠", "🌾", "🌻", "🌱", "🧑‍🌾", "🍅", "🥕", "🥦"], numberOfPairOfCards: 7, color: "green"),
        Theme(name: "Animals", emojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵", "🐔", "🐧", "🐦", "🦅", "🦉", "🐙", "🐳", "🐁"], numberOfPairOfCards: 5, color: "pink"),
        Theme(name: "Weather", emojis: ["🌞", "🌝", "🌤", "⛅️", "🌥", "☁️", "🌦", "🌧", "⛈", "🌩", "🌨", "☃️", "🌬", "☔️", "🌫", "❄️", "🌪", "⚡️", "🌚", "🌙", "🌛", "🌜", "🌑", "🌕"], numberOfPairOfCards: 8, color: "yellow"),
        Theme(name: "Fruits", emojis: ["🍒","🍓", "🍇", "🍎", "🍉", "🍑", "🍊", "🍋", "🍌", "🍏", "🍈", "🍐", "🥝", "🥭", "🥥", "🫐"], numberOfPairOfCards: 6, color: "lime"),
        Theme(name: "Food", emojis: ["🥘", "🍲", "🍛", "🍜", "🍤", "🥟", "🍦", "🥞", "🍪", "🥨", "🥮", "🍢", "🥐", "🫕", "🫔", "🦪", "🍙", "🍘", "🥪", "🥧"], numberOfPairOfCards: 3, color: "purple")
    ]
       
    @Published private var model: MemoryGame<String>
    // private var means the View cannot see or change model, @Published so ViewModel will publish a change whenever model changes
    
    var cards: Array<Card> {
        // as model is private, in order for View to access the cards in the game, we need to create a var that returns an array of cards
        model.cards // returns an array of cards in the MemoryGame
    }
    
    var currentScore: Int {
        model.score
    }
    
    var colorOfCurrentTheme: Color? = nil
    
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
        
    // MARK: - Intent(s)
        /* "Mark: -" creates a bookmark section in the top nav bar
         Here we will create a function that registers user intent. In memorygame, the only user intent is to choose a card, i.e. translate a tap gesture -> choosing a card
         */
    
    func choose (_ card : Card) { // define external and internal label
        model.choose(card)
    }
    
    func newGame() {
        currentTheme = themes.randomElement()!
        colorOfCurrentTheme = determineThemeColor(themeColor: currentTheme.color)
        model = EmojiMemoryGame.createMemoryGame(of: currentTheme)
    }
    
    func shuffle() {
        model.shuffle()
    }
}
