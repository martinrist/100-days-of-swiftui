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
  @State private var inputImage: UIImage?

  @State private var filterIntensity = 0.5
  @State private var showingImagePicker = false

  @State private var currentFilter = CIFilter.sepiaTone()
  let context = CIContext()

  var body: some View {

    let intensity = Binding<Double>(
      get: {
        filterIntensity
      },
      set: {
        filterIntensity = $0
        applyProcessing()
      })

    return NavigationView {
      VStack {
        ZStack {
          Rectangle()
            .fill(Color.secondary)

          if let image = image {
            image
              .resizable()
              .scaledToFit()
          } else {
            Text("Tap to select a picture")
              .foregroundColor(.white)
              .font(.headline)
          }
        }
        .onTapGesture {
          showingImagePicker = true
        }

        HStack {
          Text("Intensity")
          Slider(value: intensity)
        }
        .padding(.vertical)

        HStack {
          Button("Change filter") {
            // change filter
          }

          Spacer()

          Button("Save") {
            // save picture
          }
        }
      }
      .padding([.horizontal, .bottom])
      .navigationTitle("Instafilter")
      .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
        ImagePicker(image: $inputImage)
      }
    }
  }

  func loadImage() {
    guard let inputImage = inputImage else { return }

    let beginImage = CIImage(image: inputImage)
    currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
    applyProcessing()
  }

  func applyProcessing() {
    currentFilter.intensity = Float(filterIntensity)
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
