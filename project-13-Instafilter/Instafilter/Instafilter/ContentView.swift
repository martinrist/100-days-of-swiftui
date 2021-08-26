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
  @State private var showingFilterSheet = false

  @State private var processedImage: UIImage?

  @State private var currentFilter: CIFilter = CIFilter.sepiaTone()

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
            showingFilterSheet = true
          }

          Spacer()

          Button("Save") {
            guard let processedImage = processedImage else { return }
            let imageSaver = ImageSaver()
            imageSaver.successHandler = {
              print("Success")
            }
            imageSaver.errorHandler = {
              print("Oops: \($0.localizedDescription)")
            }
            imageSaver.writeToPhotoAlbum(image: processedImage)
          }
        }
      }
      .padding([.horizontal, .bottom])
      .navigationTitle("Instafilter")
      .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
        ImagePicker(image: $inputImage)
      }
      .actionSheet(isPresented: $showingFilterSheet) {
        ActionSheet(title: Text("Select a filter"), buttons: [
          .default(Text("Crystallize")) { setFilter(CIFilter.crystallize()) },
          .default(Text("Edges")) { setFilter(CIFilter.edges()) },
          .default(Text("Gaussian Blur")) { setFilter(CIFilter.gaussianBlur()) },
          .default(Text("Pixellate")) { setFilter(CIFilter.pixellate()) },
          .default(Text("Sepia Tone")) { setFilter(CIFilter.sepiaTone()) },
          .default(Text("Unsharp Mask")) { setFilter(CIFilter.unsharpMask()) },
          .default(Text("Vignette")) { setFilter(CIFilter.vignette()) }
        ])
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

    let inputKeys = currentFilter.inputKeys
    if inputKeys.contains(kCIInputIntensityKey) {
      currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
    }
    if inputKeys.contains(kCIInputRadiusKey) {
      currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)
    }
    if inputKeys.contains(kCIInputScaleKey) {
      currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
    }

    guard let outputImage = currentFilter.outputImage else { return }
    if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
      let uiImage = UIImage(cgImage: cgImage)
      image = Image(uiImage: uiImage)
      processedImage = uiImage
    }
  }

  func setFilter(_ filter: CIFilter) {
    currentFilter = filter
    loadImage()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
