//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Martin Rist on 19/06/2021.
//

import SwiftUI

struct ContentView: View {

  private let moves = ["Rock", "Paper", "Scissors"]

  @State private var appMove = 0
  @State private var shouldWin = Bool.random()
  @State private var playerWonRound = false
  @State private var score = 0
  @State private var round = 0
  @State private var roundResultIsShowing = false
  @State private var gameResultIsShowing = false

  var body: some View {

    VStack(spacing: 20) {
      Text("Round: \(round)")
      Text("Score: \(score)")

      Text("App move: \(moves[appMove])")
      Text("Play to \(shouldWin ? "win" : "lose")")
        .alert(isPresented: $gameResultIsShowing) {
          Alert(title: Text("End of Game"),
                message: Text("You scored \(score) points"),
                dismissButton: .default(Text("New Game")) {
            newGame()
          })}

      ForEach(0..<moves.count) { playerMove in
        Button("\(moves[playerMove])") {
          playerWonRound = result(appMove: appMove, playerMove: playerMove, shouldWin: shouldWin)
          score += playerWonRound ? 1 : -1
          roundResultIsShowing = true
        }
        .alert(isPresented: $roundResultIsShowing) {
          Alert(title: Text("Round \(round) Result"),
                message: Text("You \(playerWonRound ? "got" : "lost") a point"),
                dismissButton: .default(Text("Next Round")) {
            nextRound()
          })}
      }
    }
    .onAppear(perform: newGame)
  }

  func newGame() {
    round = 0
    score = 0
    nextRound()
  }

  func nextRound() {
    appMove = Int.random(in: 0..<moves.count)
    shouldWin = Bool.random()
    if round == 5 {
      DispatchQueue.main.async {
        gameResultIsShowing = true
      }
    } else {
      round += 1
    }
  }

  func result(appMove: Int, playerMove: Int, shouldWin: Bool) -> Bool {
    let playerWon = (appMove + 1) % 3 == playerMove
    return playerWon == shouldWin
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
