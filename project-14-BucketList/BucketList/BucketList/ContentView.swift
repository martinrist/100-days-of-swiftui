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
  @State private var locations = [CodableMKPointAnnotation]()
  @State private var selectedPlace: MKPointAnnotation?
  @State private var showingPlaceDetails = false
  @State private var showingEditScreen = false

  var body: some View {
    ZStack {
      MapView(centerCoordinate: $centerCoordinate,
              selectedPlace: $selectedPlace,
              showingPlaceDetails: $showingPlaceDetails,
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
            let newLocation = CodableMKPointAnnotation()
            newLocation.coordinate = centerCoordinate
            newLocation.title = "Example Location"
            newLocation.subtitle = "Description"
            locations.append(newLocation)

            selectedPlace = newLocation
            showingEditScreen = true
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
    .alert(isPresented: $showingPlaceDetails) {
      Alert(title: Text(selectedPlace?.title ?? "Unknown"),
            message: Text(selectedPlace?.subtitle ?? "Missing place information"),
            primaryButton: .default(Text("OK")),
            secondaryButton: .default(Text("Edit")) {
        showingEditScreen = true
      })
    }
    .sheet(isPresented: $showingEditScreen, onDismiss: saveData) {
      if let selectedPlace = selectedPlace {
        EditView(placemark: selectedPlace)
      }
    }
    .onAppear(perform: loadData)
  }

  func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }

  func loadData() {
    let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
    do {
      let data = try Data(contentsOf: filename)
      locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
    } catch {
      print("Unable to load saved data: \(error.localizedDescription)")
    }
  }

  func saveData() {
    do {
      let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
      let data = try JSONEncoder().encode(locations)
      try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
    } catch {
      print("Unable to save data")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
