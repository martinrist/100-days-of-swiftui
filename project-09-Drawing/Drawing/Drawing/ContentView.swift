//
//  ContentView.swift
//  Drawing
//
//  Created by Martin Rist on 06/07/2021.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationView {
      List {
        NavigationLink(destination: PathExampleView()) {
          Text("`Path` example")
        }
        NavigationLink(destination: ShapeExampleView()) {
          Text("`Shape` example")
        }
        NavigationLink(destination: InsettableShapeExampleView()) {
          Text("`InsettableShape` example")
        }
        NavigationLink(destination: CGAffineTransformExampleView()) {
          Text("`CGAffineTransform` example")
        }
      }
      .navigationBarTitle("Drawing")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
