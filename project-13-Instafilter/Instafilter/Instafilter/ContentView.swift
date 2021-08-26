//
//  ContentView.swift
//  Instafilter
//
//  Created by Martin Rist on 24/08/2021.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins


class ImageSaver: NSObject {
  func writeToPhotosAlbum(image: UIImage) {
    UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
  }

  @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    print("Save finished!")
  }
}

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
    let imageSaver = ImageSaver()
    imageSaver.writeToPhotosAlbum(image: inputImage)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
