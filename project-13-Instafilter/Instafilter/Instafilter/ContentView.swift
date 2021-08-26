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
  @State private var filterIntensity = 0.5

  var body: some View {
    NavigationView {
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

          // display the image
        }
        .onTapGesture {
          // select and image
        }

        HStack {
          Text("Intensity")
          Slider(value: $filterIntensity)
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

    }
  }

}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
