//
//  MemoryGame.swift
//  Memorize
//
//  Created by Dana Zou on 16/10/2022.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private (set) var cards: Array<Card> // unset variable
    
    private var indexOfTheOnlyFaceUpCard: Int? // keeps track of the index of the only face up card on the board
    
    private (set) var score: Int // keeps track of score
    
    mutating func choose(_ card: Card) { // use mutating to allow choose to change values created within the struct model
        /*
         Called when user touches a card
         */

        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            /*
             firstIndex is a function that's part of Array. It returns the first index of an element that satisfies the requirement: element.id == card.id
             */
            cards[chosenIndex].numberOfTimesSeen += 1
            if let potentialMatchIndex = indexOfTheOnlyFaceUpCard { // when there's already 1 (and only 1) card flipped on screen
                if cards[chosenIndex].content == cards[potentialMatchIndex].content{ // check to see if there's a match
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else if cards[chosenIndex].numberOfTimesSeen > 1 && cards[potentialMatchIndex].numberOfTimesSeen > 1{
                    score -= 2
                } else if cards[chosenIndex].numberOfTimesSeen > 1 || cards[potentialMatchIndex].numberOfTimesSeen > 1 {
                    score -= 1
                }
                indexOfTheOnlyFaceUpCard = nil // all cards face down
            }
            
            else {
                for index in cards.indices{ // flip over all the cards
                    cards[index].isFaceUp = false
                }
                indexOfTheOnlyFaceUpCard = chosenIndex
            }
            print("number of times you've seen this card is \(cards[chosenIndex].numberOfTimesSeen)")
            cards[chosenIndex].isFaceUp.toggle() // toggles the value of Bool from true <-> false
        }
    }
    
    init(numberOfPairOfCards: Int, emojiGameScore: Int, createCardContent: (Int) -> CardContent){
        /*
         initialise unset variables (cards) within MemoryGame. now, whenever you call on MemoryGame, you can't / don't need to initialise the var cards. Instead, you pass the arguments of init whenever you call MemoryGame
        Inputs: int for numberOfPairOfCards & function that creates CardContent
         */
        cards = Array<Card>() // create an empty array of cards
        // add numberOfPairOfCards x 2 cards to card array

        for pairIndex in 0..<numberOfPairOfCards{
            let content = createCardContent(pairIndex)
            /*
             The Model shouldn't need to know what the content of the cards are as "CardContent" is a generic type. The code that calls on MemoryGame will define the content of the cards
             createCardContent is a function that takes an int and returns a CardContent. it is an argument to the init function. Whenever you create something that is of type MemoryGame, you need to define a) numberOfPairOfCards and b) createCardContent
             */
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        
        cards = cards.shuffled()
        score = emojiGameScore
    }
    
    struct Card: Identifiable{
        // asking Card to behave like an Identifiable to use it in ForEach function
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var numberOfTimesSeen: Int = 0
        var content: CardContent
        var id: Int
    }
}

