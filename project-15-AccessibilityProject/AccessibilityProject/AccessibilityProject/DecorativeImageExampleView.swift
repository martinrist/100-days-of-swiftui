//
//  DecorativeImageExampleView.swift
//  DecorativeImageExampleView
//
//  Created by Martin Rist on 31/08/2021.
//

import SwiftUI

struct DecorativeImageExampleView: View {
  var body: some View {
    Image(decorative: "galina-n-189483")
      .resizable()
      .scaledToFit()
  }
}

struct DecorativeImageExampleView_Previews: PreviewProvider {
  static var previews: some View {
    DecorativeImageExampleView()
  }
}
