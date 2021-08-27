//
//  Question.swift
//  TableTester
//
//  Created by Martin Rist on 04/07/2021.
//

import Foundation

struct Question: Hashable, Equatable {

  let operand1: Int
  let operand2: Int

  var questionText: String {
    "\(operand1) times \(operand2)"
  }

  var correctAnswer: Int {
    operand1 * operand2
  }

  func isCorrect(answer: Int) -> Bool {
    answer == correctAnswer
  }
}
