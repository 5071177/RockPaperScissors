//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Yury Prokhorov on 09.12.2021.
//

import SwiftUI



struct ContentView: View {
    
    @State private var moves = ["Paper", "Rock", "Scissors"].shuffled()
    @State private var moveChoice = Int.random(in: 0...2)
    
    @State private var shouldWin = Bool.random()
    
    @State private var userScore = 0
    
    
    
    var body: some View {
        VStack {
            Text("\(userScore)")
            Text("\(moves[moveChoice])")
            Text(shouldWin ? "win" : "lose")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
