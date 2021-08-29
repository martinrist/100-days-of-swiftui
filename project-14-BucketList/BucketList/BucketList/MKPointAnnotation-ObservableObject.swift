//
//  MKPointAnnotation-ObservableObject.swift
//  MKPointAnnotation-ObservableObject
//
//  Created by Martin Rist on 29/08/2021.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
  public var wrappedTitle: String {
    get {
      title ?? "Unkown value"
    }
    set {
      title = newValue
    }
  }

  public var wrappedSubtitle: String {
    get {
      subtitle ?? "Unkown value"
    }
    set {
      subtitle = newValue
    }
  }
}
