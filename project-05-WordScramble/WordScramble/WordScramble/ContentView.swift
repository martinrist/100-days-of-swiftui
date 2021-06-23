//
//  ContentView.swift
//  WordScramble
//
//  Created by Martin Rist on 22/06/2021.
//

import SwiftUI

struct ContentView: View {

  @State private var usedWords = [String]()
  @State private var rootWord = ""
  @State private var newWord = ""

  var body: some View {
    NavigationView {
      VStack {
        TextField("Enter your word", text: $newWord, onCommit: addNewWord)
          .autocapitalization(.none)
          .textFieldStyle(.roundedBorder)
          .padding()

        List(usedWords, id: \.self) {
          Image(systemName: "\($0.count).circle")
          Text($0)
        }
      }
      .navigationTitle(rootWord)
    }

  }

  func addNewWord() {
    let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

    guard answer.count > 0 else { return }

    // extra validation here

    usedWords.insert(answer, at:0)
    newWord = ""
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
