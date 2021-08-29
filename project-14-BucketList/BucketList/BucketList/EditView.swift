//
//  EditView.swift
//  EditView
//
//  Created by Martin Rist on 29/08/2021.
//

import SwiftUI
import MapKit

struct EditView: View {

  @Environment(\.presentationMode) var presentationMode
  @ObservedObject var placemark: MKPointAnnotation

  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField("Place name", text: $placemark.wrappedTitle)
          TextField("Description", text: $placemark.wrappedSubtitle)
        }
      }
      .navigationBarTitle("Edit place")
      .navigationBarItems(trailing: Button("Done") {
        presentationMode.wrappedValue.dismiss()
      })
    }
  }
}

struct EditView_Previews: PreviewProvider {
  static var previews: some View {
    EditView(placemark: MKPointAnnotation.example)
  }
}
