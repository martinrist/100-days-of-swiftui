//
//  BlendModeExampleView.swift
//  Drawing
//
//  Created by Martin Rist on 07/07/2021.
//

import SwiftUI

struct BlendModeExampleView: View {
  var body: some View {
    ZStack {
      Image("Sculpture")
        .resizable()
        .scaledToFill()

      Rectangle()
        .fill(Color.red)
        .blendMode(.multiply)
    }
    .edgesIgnoringSafeArea(.all)
  }
}

struct BlendModeExampleView_Previews: PreviewProvider {
  static var previews: some View {
    BlendModeExampleView()
  }
}
