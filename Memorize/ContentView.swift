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
    
    @Namespace private var dealingNamespace
    
    var body: some View {
        ZStack (alignment: .bottom) {
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
                .padding(.horizontal)
                
            }
            .padding(.horizontal)
            deckBody
                .padding(.bottom, 40.0)
        }
    }
    
    var header: some View {
        HStack(alignment: .bottom){
            Text("\(viewModel.theme.name)")
                .font(.title).fontWeight(.bold)
            
            Spacer()
            
            Text("Score: \(viewModel.currentScore)")
                .padding(.trailing, 10.0)
                .padding(.bottom, 3.0)
        }
    }
    
    @State private var dealt = Set<Int>()
    
    func deal (_ card: EmojiMemoryGame.Card) {
        dealt.insert(card.id)
    }
    
    func isUndealt (_ card: EmojiMemoryGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    func dealAnimation (for card: EmojiMemoryGame.Card) -> Animation {
        var delay = 0.0
        if let index = viewModel.cards.firstIndex(where: {$0.id == card.id}) {
            delay = Double(index) * (CardConstants.totalDealDuration / Double(viewModel.cards.count))
        }
        return Animation.easeInOut.delay(delay)
    }
    
    func zIndex (_ card: EmojiMemoryGame.Card) -> Double {
        -Double(viewModel.cards.firstIndex(where: {$0.id == card.id}) ?? 0)
    }
    
    var gameBody: some View {
        AspectVGrid (items: viewModel.cards, aspectRatio: CardConstants.aspectRatio) { card in
            if isUndealt(card) || (card.isMatched && !card.isFaceUp) {
                Color.clear
            } else {
                CardView(card: card)
                    .padding(4)
                    .zIndex(zIndex(card))
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale).animation(.easeInOut))
                    .onTapGesture {
                        withAnimation {
                            viewModel.choose(card)
                        }
                    }
            }
        }
        .foregroundColor(viewModel.determineThemeColor(themeColor: viewModel.theme.color))

    }
    
    var deckBody: some View {
        ZStack {
            ForEach (viewModel.cards.filter(isUndealt)) { card in
                CardView(card: card)
                    .zIndex(zIndex(card))
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
            }
        }
        .foregroundColor(viewModel.determineThemeColor(themeColor: viewModel.theme.color))
        .frame(width: CardConstants.deckWidth, height: CardConstants.deckHeight)
        .onTapGesture {
            for card in viewModel.cards {
                withAnimation (dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
    }
    
    private struct CardConstants {
        static let aspectRatio: CGFloat = 2/3
        static let deckHeight: CGFloat = 100
        static let deckWidth = deckHeight * aspectRatio
        static let totalDealDuration: Double = 0.5
    }
    
    var newGame: some View {
        Button("New Game") {
            withAnimation {
                dealt = []
                viewModel.newGame()
            }
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
    

