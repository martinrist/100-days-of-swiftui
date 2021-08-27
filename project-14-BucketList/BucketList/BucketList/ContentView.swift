//
//  ContentView.swift
//  BucketList
//
//  Created by Martin Rist on 27/08/2021.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
  @State private var isUnlocked = false

  var body: some View {
    VStack {
      if isUnlocked {
        Text("Unlocked")
      } else {
        Text("Locked")
      }
    }
    .onAppear(perform: authenticate)
  }

  func authenticate() {
    let context = LAContext()
    var error: NSError?

    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
      let reason = "We need to unlock your data."

      context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                             localizedReason: reason) { success, authenticationError in
        DispatchQueue.main.async {
          if success {
            isUnlocked = true
          } else {
            // there was a problem
          }
        }
      }
    } else {
      // no biometrics
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
