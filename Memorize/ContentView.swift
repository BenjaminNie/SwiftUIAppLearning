//
//  ContentView.swift
//  Memorize
//
//  Created by ben nie on 1/14/25.
//

import SwiftUI

struct ContentView: View {
    @State var theme = 0

    let oceanicTheme:[String] = ["🦑", "🪼", "🦞", "🐠", "🐋", "🐡"]
    let fastfoodTheme:[String] = ["🍔", "🌮", "🫔", "🍟"]
    let sportsTheme:[String] = ["⚽️", "🥎", "🏉", "🎱", "🏐"]

    var oceanicCards:[CardView] = []
    var fastfoodCards:[CardView] = []
    var sportCards:[CardView] = []

    init() {
        addCards(from: oceanicTheme, to: &oceanicCards)
        addCards(from: fastfoodTheme, to: &fastfoodCards)
        addCards(from: sportsTheme, to: &sportCards)
    }
    
    var body: some View {
        VStack {
            title
            Spacer()
            cards
            Spacer()
            themeButtons
        }
        .padding()
    }

    func whichCards() -> [CardView] {
        var cards:[CardView]
        switch theme {
        case 1:
            cards = oceanicCards
        case 2:
            cards = fastfoodCards
        case 3:
            cards = sportCards
        default:
            cards = oceanicCards
        }
        cards.shuffle()
        return cards
    }

    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 65, maximum: 65))]) {
            let cards = whichCards()
            ForEach(0..<cards.count, id:\.self) { index in
                cards[index]
            }
        }
    }

    var title: some View {
        Text("Memorize!")
            .font(.system(size:50))
    }

    var themeButtons: some View {
        HStack {
            ForEach(1..<4) { index in
                themeButton(for: index)
            }
        }
    }
/*
    private func getCards() -> [CardView] {
        switch self.theme {
        case 0:
            return self.oceanicCards
        case 1:
            return self.fastfoodCards
        case 2:
            return self.sportCards
        default:
            assert(false)
        }
    }*/

    private func addCards(from theme: [String], to cards: inout [CardView]) {
        for icon in theme {
            let card = CardView(content: icon)
            let card2 = CardView(content: icon)
            cards.append(card)
            cards.append(card2)
        }
    }

    func themeButton(for index: Int) -> some View {
        Button(action: {
            theme = index
        }) {
            Text("\(index)")
                .padding()
        }
        .border(Color.black, width:2)
    }
}

struct CardView: View {
    @State var isFaceUp = true
    let base = RoundedRectangle(cornerRadius: 12)
    let content: String

    var body: some View {
        ZStack {
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1:0)
            base.fill().opacity(isFaceUp ? 0:1)
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
