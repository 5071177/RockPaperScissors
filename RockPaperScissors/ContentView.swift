//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Yury Prokhorov on 09.12.2021.
//

import SwiftUI



struct ContentView: View {
    
    @State private var moves = ["✋", "✊", "✌️"].shuffled()
    @State private var moveChoice = Int.random(in: 0...2)
    
    @State private var moveToWin = ""
    @State private var moveToLose = ""
    
    @State private var correctChoice = ""
    
    
    @State private var shouldWin = Bool.random()
    
    @State private var showingScore = false
    @State private var userScore = 0
    @State private var scoreTitle = ""
    
    
    @State private var restartingGame = false
    @State private var numberOfTries = 0
    @State private var restartTitle = ""
    
    // Что юзер должен выбрать для победы
    func whatMoveToWin (appMove: String) -> String{
        switch appMove{
        case "✊":
            return "✋"
        case "✋":
            return "✌️"
        default:
            return "✊"
        }
    }

    // Что юзер должен выбрать для поражения
    func whatMoveToLose (appMove: String) -> String {
        switch appMove{
        case "✊":
            return "✌️"
        case "✋":
            return "✊"
        default:
            return "✋"
        }
    }

    // Что юзер должен выбрать для корректного ответа
    func whatCorrectChoice (_ shouldWin: Bool) -> String{
        if shouldWin == true {
            correctChoice = whatMoveToWin(appMove: moves[moveChoice])
        } else {
            correctChoice = whatMoveToLose(appMove: moves[moveChoice])
        }
        return correctChoice
    }
    
    
    // Проверка количества попыток
    func checkNumberOfTries () {
            if numberOfTries == 8 {
                restartingGame = true
                restartTitle = "Last attempt, try again"
            }
            else {
                return restartingGame = false
            }
        }
    
    // Проверка правильности ответа после нажатия
    func moveTapped (_ move: String) {
            if move == whatCorrectChoice(shouldWin) {
                scoreTitle = "Correct"
                userScore += 1
            } else{
                scoreTitle = "Wrong"
                userScore -= 1
            }

            showingScore = true
            numberOfTries += 1
            checkNumberOfTries()
        }

    
    func askQuestion() {
            moves.shuffle()
            moveChoice = Int.random(in: 0...2)
        shouldWin = Bool.random()
        }
    
    
    func reset() {
            showingScore = false
            scoreTitle = ""
            
            userScore = 0
            
            restartingGame = false
            numberOfTries = 0
            restartTitle = ""
        }
    
    
    
    
    var body: some View {
        VStack (spacing: 30){
            Text("\(userScore)")
            Text("\(moves[moveChoice])").font(.system(size: 50))
            Text(shouldWin ? "You need to win" : "You need to lose")
            
            
            HStack{
             ForEach(0..<3) { number in
                        Button(moves[number]) {
                            moveTapped(moves[number])
                        }
                        .font(.system(size: 100))
                    }
        }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
                    Button("Continue", action: askQuestion)
                } message: {
                    Text("Your score is \(userScore)")
                }
                                .alert(restartTitle, isPresented: $restartingGame) {
                                    Button("Try again", action: reset)
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
