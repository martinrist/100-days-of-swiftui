//
//  SetupView.swift
//  TableTester
//
//  Created by Martin Rist on 04/07/2021.
//

import SwiftUI

enum QuizSize {
  case fixed(quantity: Int)
  case all

  var description: String {
    switch self {
    case .all:
      return "All"
    case .fixed(let quantity):
      return "\(quantity)"
    }
  }
}

struct SetupView: View {
  @Binding var settingUp: Bool
  @Binding var questions: [Question]

  @State private var maxTable = 12
  @State private var quizSizeOptions: [QuizSize] = [.fixed(quantity: 5),
                                                    .fixed(quantity: 10),
                                                    .fixed(quantity: 20),
                                                    .all]
  @State private var quizSizeOptionSelection = 0

  var body: some View {
    Form {
      Section(header: Text("Which tables would you like to practice?")) {
        Stepper(value: $maxTable, in: 2...12) {
          Text("Up to \(maxTable)x table")
        }
      }

      Section(header: Text("How many questions would you like?")) {
        Picker("How many questions?", selection: $quizSizeOptionSelection) {
          ForEach(0..<quizSizeOptions.count) {
            Text(quizSizeOptions[$0].description)
          }
        }
        .pickerStyle(.segmented)
      }
    }
    .navigationBarTitle("Setup")
    .navigationBarItems(trailing: Button("Play") {
      questions = generateQuestions(upToTable: maxTable, quizSize: quizSizeOptions[quizSizeOptionSelection])
      settingUp.toggle()
    })
  }

  func generateQuestions(upToTable: Int, quizSize: QuizSize) -> [Question] {
    let allQuestions =
    (1...upToTable).flatMap { op1 in
      (1...12).map { op2 in (op1, op2) }
    }
    .map { (op1, op2) in
      Question(operand1: op1, operand2: op2)
    }
    .shuffled()

    switch quizSize {
    case .all:
      return allQuestions
    case .fixed(let quantity):
      return Array(allQuestions.prefix(quantity))
    }
  }
}

struct SetupView_Previews: PreviewProvider {
  static var previews: some View {
    SetupView(settingUp: .constant(true), questions: .constant([]))
  }
}
