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
  @State private var showingImagePicker = false
  @State private var inputImage: UIImage?

  var body: some View {
    VStack {
      image?
        .resizable()
        .scaledToFit()

      Button("Select Image") {
        showingImagePicker = true
      }
    }
    .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
      ImagePicker(image: $inputImage)
    }
  }

  func loadImage() {
    guard let inputImage = inputImage else { return }
    image = Image(uiImage: inputImage)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
