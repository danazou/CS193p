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
        
        VStack {
            Spacer(minLength: 20)
            header
            gameBody
            HStack {
                shuffle
                Spacer()
                newGame
            }
            .foregroundColor(.blue)
            .padding(.horizontal, 50)
            
        }
        .padding(.horizontal)
    }
    
    var header: some View {
        HStack(alignment: .bottom){
            Text("\(viewModel.currentTheme.name)")
                .font(.title).fontWeight(.bold)
            
            Spacer()
            
            Text("Score: \(viewModel.currentScore)")
                .padding(.trailing, 10.0)
                .padding(.bottom, 3.0)
        }
    }
    
    var gameBody: some View {
        AspectVGrid (items: viewModel.cards, aspectRatio: 2/3) { card in
            if card.isMatched && !card.isFaceUp {
                Color.clear
            } else {
                CardView(card: card)
                    .padding(4)
                    .onTapGesture {
                        withAnimation {
                            viewModel.choose(card)
                        }
                    }
            }
        }
        .foregroundColor(viewModel.determineThemeColor(themeColor: viewModel.currentTheme.color))
    }
    
    var newGame: some View {
        Text("New Game")
//            .foregroundColor(.blue)
            .onTapGesture {
                viewModel.newGame()
            }
    }
    
    var shuffle: some View {
        Text("Shuffle").onTapGesture {
            withAnimation {
                viewModel.shuffle()
            }
        }
    }
}
    
struct CardView: View{
    /* View that shows what a card looks like.
     
     Input: card as defined in the Model (note: we are only giving View a portion of the Model, only what is needed)
     Output: body of type some View -> an UI that shows a card in the Model
     
     */
    
    let card: EmojiMemoryGame.Card // accessing information in the model to build Card view, read-only
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // need to add Pie from Lecture 6
                Text(card.content)
                    .rotationEffect(.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 0.8).repeatForever(autoreverses: false), value: card.isMatched)
                    .font(font(in: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private func font (in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
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
    

