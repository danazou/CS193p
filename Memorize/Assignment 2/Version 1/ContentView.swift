//
//  ContentView.swift
//  Memorize
//
//  Created by Dana Zou on 15/10/2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    /* the value of viewModel needs to be initialised. This can be done in 2 ways, initialise it directly in the same line or pass the value of viewModel each time ContentView is called.
     We've decided to do the latter - every time ContentView is called, we need to define viewModel
     */
    var body: some View {
        let myColor = viewModel.determineThemeColor(themeColor: EmojiMemoryGame.currentTheme.color)
        let myScore = viewModel.currentScore
        
        VStack{
            
            Spacer()
            HStack(alignment: .bottom){
                Text("\(EmojiMemoryGame.currentTheme.name)")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal, 10.0)
                
                Spacer()
                
                Text("Score: \(myScore)")
                    .padding(.trailing, 10.0)
                    .padding(.bottom, 3.0)
            }
            
            // Show emoji cards in the selected theme in grid format, each card is in 2:3 aspect ratio.
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]){
                    // We want View to display cards. Loop through the cards in viewModel
                    ForEach(viewModel.cards) { card in // input of card because viewModel.cards is Array<Card>
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                // record user action and translate it to user intent
                                viewModel.choose(card) // recall that we defined card in struct CardView
                            }
                    }
                }
            }
            .foregroundColor(myColor)
            
            Text("New Game")
                .font(.subheadline).foregroundColor(.blue)
                .onTapGesture {
                    viewModel.newGame()
                }
        }
        .padding(.horizontal)
    }
    
    
    struct CardView: View{
        /* View that shows what a card looks like.
         
         Input: card as defined in the Model (note: we are only giving View a portion of the Model, only what is needed)
         Output: body of type some View -> an UI that shows a card in the Model
         
         */
        
        let card: MemoryGame<String>.Card // accessing information in the model to build Card view, read-only
        
        var body: some View{
            ZStack {
                let shape = RoundedRectangle(cornerRadius: 8)
        
                if card.isFaceUp {
                    // recall that isFaceUp is a var we defined in Model(MemoryGame)
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: 3)
                    Text(card.content).font(.title)
                } else if card.isMatched{
                    shape.opacity(0) // still taking up space but not showing the card
                    Text(" ").font(.title)
                }
                else {
                    shape.fill()
                    Text(" ").font(.title)
                }
            }
        }
    }
    

    
    
    
    
    
 
    
    
    
    
    
    
    
    
    
    
    
    
// Configure XCode preview
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            let game = EmojiMemoryGame()
            ContentView(viewModel: game)
                .preferredColorScheme(.light)
            ContentView(viewModel: game)
                .previewInterfaceOrientation(.portrait)
                .preferredColorScheme(.dark)
        }
    }
    
}
