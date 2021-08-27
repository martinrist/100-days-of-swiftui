//
//  MapView.swift
//  MapView
//
//  Created by Martin Rist on 27/08/2021.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {

  func makeUIView(context: Context) -> some UIView {
    let mapView = MKMapView()
    return mapView
  }

  func updateUIView(_ uiView: UIViewType, context: Context) {
    // add code here
  }
}

struct MapView_Previews: PreviewProvider {
  static var previews: some View {
    MapView()
  }
}
