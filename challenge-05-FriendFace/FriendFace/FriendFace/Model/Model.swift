//
//  Model.swift
//  Model
//
//  Created by Martin Rist on 23/08/2021.
//

import Foundation

class Model: ObservableObject {

  var dataLoader: DataLoader

  @Published var users = [User]()
  @Published var error: DataLoadError?

  init(dataLoader: DataLoader = NetworkDataLoader()) {
    self.dataLoader = dataLoader
  }

  func loadData() {
    dataLoader.loadData { result in
      switch result {
        case .success(let users):
        DispatchQueue.main.async {
          self.error = nil
          self.users = users
        }
        case .failure(let error):
        DispatchQueue.main.async {
          print("Error loading data: \(error.localizedDescription)")
          self.error = error
        }
      }
    }
  }
}

