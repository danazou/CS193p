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
        let myColor = viewModel.determineThemeColor(themeColor: viewModel.currentTheme.color)
        let myScore = viewModel.currentScore
        
        VStack{
            Spacer()
            HStack(alignment: .bottom){
                Text("\(viewModel.currentTheme.name)")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                Text("Score: \(myScore)")
                    .padding(.trailing, 10.0)
                    .padding(.bottom, 3.0)
            }

            // Show emoji cards in the selected theme in grid format, each card is in 2:3 aspect ratio.
            AspectVGrid (items: viewModel.cards, aspectRatio: 2/3) { card in
                if card.isMatched && !card.isFaceUp {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card) // recall that we defined card in struct CardView
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
}
    
struct CardView: View{
    /* View that shows what a card looks like.
     
     Input: card as defined in the Model (note: we are only giving View a portion of the Model, only what is needed)
     Output: body of type some View -> an UI that shows a card in the Model
     
     */
    
    let card: EmojiMemoryGame.Card // accessing information in the model to build Card view, read-only
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
        
                if card.isFaceUp {
                    // recall that isFaceUp is a var we defined in Model(MemoryGame)
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched{
                    shape.opacity(0) // still taking up space but not showing the card
                }
                else {
                    shape.fill()
                }
            }
        }
    }
    
    private func font (in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 8
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.6
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
    

