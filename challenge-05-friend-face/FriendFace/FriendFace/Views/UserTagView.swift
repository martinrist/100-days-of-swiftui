//
//  UserTagView.swift
//  UserTagView
//
//  Created by Martin Rist on 23/08/2021.
//

import SwiftUI

struct UserTagView: View {

  let tag: String

  var body: some View {
    Text(tag)
      .fontWeight(.bold)
      .foregroundColor(.purple)
      .padding()
      .overlay(
        Capsule()
          .stroke(.purple, lineWidth: 3)
      )
  }
}

struct UserTagView_Previews: PreviewProvider {
  static var previews: some View {
    UserTagView(tag: "Tag Name")
  }
}
