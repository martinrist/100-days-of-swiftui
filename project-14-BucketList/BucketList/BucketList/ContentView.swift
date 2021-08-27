//
//  ContentView.swift
//  BucketList
//
//  Created by Martin Rist on 27/08/2021.
//

import SwiftUI
import MapKit

struct ContentView: View {

  @State private var centerCoordinate = CLLocationCoordinate2D()
  @State private var locations = [MKPointAnnotation]()

  var body: some View {
    ZStack {
      MapView(centerCoordinate: $centerCoordinate,
              annotations: locations)
        .edgesIgnoringSafeArea(.all)
      Circle()
        .fill(Color.blue)
        .opacity(0.3)
        .frame(width: 32, height: 32)

      VStack {
        Spacer()
        HStack {
          Spacer()
          Button(action: {
            let newLocation = MKPointAnnotation()
            newLocation.coordinate = centerCoordinate
            locations.append(newLocation)
          }) {
            Image(systemName: "plus")
          }
          .padding()
          .background(Color.black.opacity(0.75))
          .foregroundColor(.white)
          .font(.title)
          .clipShape(Circle())
          .padding(.trailing)
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
