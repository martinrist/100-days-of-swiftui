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
  @State private var filterRadius = 0.5
  @State private var showingImagePicker = false
  @State private var showingFilterSheet = false
  @State private var showingErrorAlert = false

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

    let radius = Binding<Double>(
      get: {
        filterRadius
      },
      set: {
        filterRadius = $0
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
          Text("Radius")
          Slider(value: radius)
        }
        .padding(.vertical)

        HStack {
          Button(
            (currentFilter.attributes[kCIAttributeFilterDisplayName] as? String) ?? "Change Filter") {
            showingFilterSheet = true
          }

          Spacer()

          Button("Save") {
            guard let _ = inputImage else {
              showingErrorAlert = true
              return
            }

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
          .alert(isPresented: $showingErrorAlert) {
            Alert(title: Text("Please select an image"),
                  message: Text("Please select an input and try again"),
                  dismissButton: .default(Text("Ok")))
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
      currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey)
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
