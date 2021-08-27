//
//  MapView.swift
//  MapView
//
//  Created by Martin Rist on 27/08/2021.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {

  @Binding var centerCoordinate: CLLocationCoordinate2D
  var annotations: [MKPointAnnotation]

  class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MapView

    init(_ parent: MapView) {
      self.parent = parent
    }

    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
      parent.centerCoordinate = mapView.centerCoordinate
    }

  }

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  func makeUIView(context: Context) -> MKMapView {
    let mapView = MKMapView()
    mapView.delegate = context.coordinator
    return mapView
  }

  func updateUIView(_ view: MKMapView, context: Context) {
    if annotations.count != view.annotations.count {
      view.removeAnnotations(view.annotations)
      view.addAnnotations(annotations)
    }
  }
}

extension MKPointAnnotation {
  static var example: MKPointAnnotation {
    let annotation = MKPointAnnotation()
    annotation.title = "London"
    annotation.subtitle = "Home to the 2012 Summer Olympics."
    annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
    return annotation
  }
}

struct MapView_Previews: PreviewProvider {
  static var previews: some View {
    MapView(centerCoordinate: .constant(MKPointAnnotation.example.coordinate),
            annotations: [MKPointAnnotation.example]
    )
  }
}
