//
//  ContentView.swift
//  Animations
//
//  Created by Martin Rist on 25/06/2021.
//

import SwiftUI

struct ContentView: View {
  @State private var dragAmount = CGSize.zero

  var body: some View {
    LinearGradient(gradient: Gradient(colors: [.yellow, .red]),
                   startPoint: .topLeading,
                   endPoint: .bottomTrailing)
      .frame(width: 200, height: 200)
      .clipShape(RoundedRectangle(cornerRadius: 10))
      .offset(dragAmount)
      .gesture(
        DragGesture()
          .onChanged { dragAmount = $0.translation }
          .onEnded { _ in
        withAnimation(.spring()) {
          dragAmount = .zero
        }
      })

      // implicit animation
      // .animation(.spring())
  }

}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
