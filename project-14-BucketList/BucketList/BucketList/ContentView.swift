//
//  ContentView.swift
//  BucketList
//
//  Created by Martin Rist on 27/08/2021.
//

import SwiftUI
import MapKit
import LocalAuthentication

struct ContentView: View {

  @State private var centerCoordinate = CLLocationCoordinate2D()
  @State private var locations = [CodableMKPointAnnotation]()
  @State private var selectedPlace: MKPointAnnotation?
  @State private var showingPlaceDetails = false
  @State private var showingEditScreen = false
  @State private var isUnlocked = false
  @State private var showingAuthErrorAlert = false

  var body: some View {
    ZStack {
      if isUnlocked {
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
        .alert(isPresented: $showingPlaceDetails) {
          Alert(title: Text(selectedPlace?.title ?? "Unknown"),
                message: Text(selectedPlace?.subtitle ?? "Missing place information"),
                primaryButton: .default(Text("OK")),
                secondaryButton: .default(Text("Edit")) {
            showingEditScreen = true
          })
        }
      } else {
        Button("Unlock Places") {
          authenticate()
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .clipShape(Capsule())
        .alert(isPresented: $showingAuthErrorAlert) {
          Alert(title: Text("Authentication Error"),
                message: Text("Please try again"),
                dismissButton: .default(Text("OK")))
        }
      }
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

  func authenticate() {
    let context = LAContext()
    var error: NSError?

    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
      let reason = "Please authenticate yourself to unlock your places."
      context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
        DispatchQueue.main.async {
          if success {
            isUnlocked = true
          } else {
            showingAuthErrorAlert = true
          }
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
