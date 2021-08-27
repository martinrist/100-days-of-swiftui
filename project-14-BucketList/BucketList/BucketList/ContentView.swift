//
//  ContentView.swift
//  BucketList
//
//  Created by Martin Rist on 27/08/2021.
//

import SwiftUI

struct ContentView: View {

  var body: some View {
    MapView()
      .edgesIgnoringSafeArea(.all)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
