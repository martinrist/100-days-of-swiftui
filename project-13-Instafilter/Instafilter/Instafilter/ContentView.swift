//
//  ContentView.swift
//  Instafilter
//
//  Created by Martin Rist on 24/08/2021.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
  @State private var image: Image?

  var body: some View {
    VStack {
      image?
        .resizable()
        .scaledToFit()
    }
    .onAppear(perform: loadImage)
  }

  func loadImage() {
    guard let inputImage = UIImage(named: "example") else { return }
    let beginImage = CIImage(image: inputImage)

    let context = CIContext()
    let currentFilter = CIFilter.sepiaTone()

    currentFilter.inputImage = beginImage
    currentFilter.intensity = 1

    guard let outputImage = currentFilter.outputImage else { return }

    if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
      let uiImage = UIImage(cgImage: cgImage)
      image = Image(uiImage: uiImage)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
