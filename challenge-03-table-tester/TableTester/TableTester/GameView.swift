//
//  GameView.swift
//  TableTester
//
//  Created by Martin Rist on 04/07/2021.
//

import SwiftUI

struct GameView: View {

  @Binding var settingUp: Bool
  var questions: [Question]

  @State private var currentQuestion: Int = 0
  @State private var currentAnswer = ""
  @State private var score = 0

  @State private var showingQuestionResult = false
  @State private var showingGameEndAlert = false
  @State private var questionResultAlertTitle = ""
  @State private var questionResultAlertMessage = ""
  @State private var questionResultDismissAction: () -> Void = {}

  private var gameOver: Bool {
    currentQuestion == questions.count
  }

  var body: some View {
    VStack(spacing: 20) {

      if gameOver {
        Text("Game Over!")
          .font(.headline)
          .alert(isPresented: $showingGameEndAlert) {
            Alert(title: Text("Game over!"),
                  message: Text("You scored \(score) points out of \(questions.count)"),
                  dismissButton: .default(Text("New Game")) {
              settingUp = true
            })
          }
        Spacer()
      } else {
        Text("Score: \(score)")
        Text("Question \(currentQuestion + 1) of \(questions.count)")
        Form {
          let question = questions[currentQuestion]
          Text("What is \(question.questionText)?")
          TextField("Your answer", text: $currentAnswer, onCommit: markQuestion)
            .keyboardType(.numberPad)
        }
        Button("Submit Answer", action: markQuestion)
          .padding()
          .alert(isPresented: $showingQuestionResult) {
            Alert(title: Text(questionResultAlertTitle),
                  message: Text(questionResultAlertMessage),
                  dismissButton: .default(Text("Next"),
                                          action: questionResultDismissAction))
          }
      }
    }
    .padding()
    .navigationBarTitle("Playing")
    .navigationBarItems(trailing: Button("Restart") {
      settingUp.toggle()
    })
  }

  func markQuestion() {
    guard let numericAnswer = Int(currentAnswer) else {
      questionResultAlertTitle = "Try again!"
      questionResultAlertMessage = "Please enter a whole number"
      questionResultDismissAction = {
        currentAnswer = ""
      }
      showingQuestionResult = true
      return
    }

    let question = questions[currentQuestion]
    let answerCorrect = question.isCorrect(answer: numericAnswer)

    score += answerCorrect ? 1 : 0
    questionResultAlertTitle = answerCorrect ? "Correct!" : "Wrong!"
    questionResultAlertMessage = "\(question.questionText) is \(question.correctAnswer)"
    questionResultDismissAction = nextQuestion
    showingQuestionResult = true
  }

  func nextQuestion() {
    currentQuestion += 1
    currentAnswer = ""
    if gameOver {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        showingGameEndAlert = true
      }
    }
  }
}

struct GameView_Previews: PreviewProvider {
  static var previews: some View {
    GameView(settingUp: .constant(false), questions: [
      Question(operand1: 5, operand2: 2),
      Question(operand1: 7, operand2: 5),
      Question(operand1: 3, operand2: 12),
      Question(operand1: 10, operand2: 4),
      Question(operand1: 7, operand2: 2)
    ])
  }
}
