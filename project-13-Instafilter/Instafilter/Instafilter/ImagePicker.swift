//
//  ImagePicker.swift
//  ImagePicker
//
//  Created by Martin Rist on 25/08/2021.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
  func makeUIViewController(context: Context) -> UIImagePickerController {
    let picker = UIImagePickerController()
    return picker
  }

  func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    // Update state here if required
  }
}
