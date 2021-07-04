//
//  SetupView.swift
//  TableTester
//
//  Created by Martin Rist on 04/07/2021.
//

import SwiftUI

enum QuestionQuantity: String, CaseIterable {
  case five = "5"
  case ten = "10"
  case twenty = "20"
  case all = "All"

  var number: Int? {
    switch self {
    case .five: return 5
    case .ten: return 10
    case .twenty: return 20
    case .all: return nil       // TODO: replace sentinel value
    }
  }
}

struct SetupView: View {
  @Binding var settingUp: Bool
  @Binding var questions: [Question]

  @State private var maxTable = 12
  @State private var numberOfQuestions = QuestionQuantity.allCases
  @State private var numberOfQuestionsOption = 0

  var body: some View {
    Form {
      Section(header: Text("Which tables would you like to practice?")) {
        Stepper(value: $maxTable, in: 2...12) {
          Text("Up to \(maxTable)x table")
        }
      }

      Section(header: Text("How many questions would you like?")) {
        Picker("How many questions?", selection: $numberOfQuestionsOption) {
          ForEach(0..<QuestionQuantity.allCases.count) {
            Text(QuestionQuantity.allCases[$0].rawValue)
          }
        }
        .pickerStyle(.segmented)
      }
    }
    .navigationBarTitle("Setup")
    .navigationBarItems(trailing: Button("Play") {
      questions = generateQuestions(upToTable: maxTable, quantity: numberOfQuestions[numberOfQuestionsOption])
      settingUp.toggle()
    })
  }

  func generateQuestions(upToTable: Int, quantity: QuestionQuantity) -> [Question] {
    let allQuestions =
    (1...upToTable).flatMap { op1 in
      (1...12).map { op2 in (op1, op2) }
    }
    .map { (op1, op2) in
      Question(operand1: op1, operand2: op2)
    }
    .shuffled()

    switch quantity {
    case .all:
      return allQuestions
    default:
      return Array(allQuestions.prefix(quantity.number ?? 0))
    }
  }
}

struct SetupView_Previews: PreviewProvider {
  static var previews: some View {
    SetupView(settingUp: .constant(true), questions: .constant([]))
  }
}
