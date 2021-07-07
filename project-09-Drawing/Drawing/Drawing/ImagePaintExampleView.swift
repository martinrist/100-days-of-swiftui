//
//  ImagePaintExampleView.swift
//  Drawing
//
//  Created by Martin Rist on 07/07/2021.
//

import SwiftUI

struct ImagePaintExampleView: View {
  var body: some View {
    Capsule()
      .strokeBorder(ImagePaint(image: Image("Example"),
                               sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5),
                               scale: 0.1), lineWidth: 20)
      .frame(width: 300, height: 200)
  }
}

struct ImagePaintExampleView_Previews: PreviewProvider {
  static var previews: some View {
    ImagePaintExampleView()
  }
}
