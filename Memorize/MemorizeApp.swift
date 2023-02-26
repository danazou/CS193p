//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Dana Zou on 15/10/2022.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    /*
     here, we create a constant game and initialise it as an EmojiMemoryGame. The free init a Class gets allows us to just do this using () -> note, this doesn't initialise any vars
     game is a constant because EmojiMemoryGame is a class (i.e. reference type), hence game is a pointer to EmojiMemoryGame. EmojiMemoryGame will change, but the pointer will not.
     */
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game) // setting the value of viewModel to game
        }
    }
}
