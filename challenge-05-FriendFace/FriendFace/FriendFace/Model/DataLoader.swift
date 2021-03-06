//
//  DataLoader.swift
//  DataLoader
//
//  Created by Martin Rist on 23/08/2021.
//

import Foundation

enum DataLoadError: Error, Identifiable {
  var id: String {
    switch self {
    case .invalidResponse:
      return "invalidResponse"
    case .httpError(let code):
      return "httpError: \(code)"
    case .noData:
      return "noData"
    case .invalidData(let message):
      return "invalidData: \(message)"
    }
  }

  var message: String {
    switch self {
    case .invalidResponse:
      return "An invalid response was received from the server"
    case .httpError(let code):
      return "Error cdoe \(code) was returned from the server"
    case .noData:
      return "Failed to retrieve any data from the server"
    case .invalidData:
      return "Invalid data was returned from the server"
    }
  }

  case invalidResponse
  case httpError(code: Int)
  case noData
  case invalidData(message: Error)
}

protocol DataLoader {
  func loadData(completion: @escaping (Result<[User], DataLoadError>) -> Void)
}

#if DEBUG
class TestDataLoader: DataLoader {
  func loadData(completion: @escaping (Result<[User], DataLoadError>) -> Void) {
    completion(.success([
      User(id: UUID(),
           name: "Martin",
           company: "AppsRUs",
           address: "907 Nelson Street, Cotopaxi, South Dakota, 5913",
           email: "martin.smith@yahoo.com",
           isActive: true,
           about: "About Martin",
           tags: ["Tag 1", "Tag 2"],
           age: 32,
           registered: Date(),
           friends: []
          ),

      User(id: UUID(),
           name: "Sally",
           company: "EvilCorp",
           address: "652 Gatling Place, Kieler, Arizona, 1705",
           email: "sally.smythe@gmail.com",
           isActive: false,
           about: "About Sally",
           tags: ["Tag 1", "Tag 2"],
           age: 18,
           registered: Date(),
           friends: []
          ),

      User(id: UUID(),
           name: "David",
           company: "David Inc",
           address: "581 Montrose Avenue, Why, Georgia, 5385",
           email: "david.williams@davidinc.com",
           isActive: true,
           about: "About David",
           tags: ["Tag 1", "Tag 2"],
           age: 62,
           registered: Date(),
           friends: []
          )
    ])
    )
  }
}
#endif

class NetworkDataLoader: DataLoader {

  func loadData(completion: @escaping (Result<[User], DataLoadError>) -> Void) {
    let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!

    URLSession.shared.dataTask(with: url) { data, response, error in
      guard let httpResponse = response as? HTTPURLResponse else {
        completion(.failure(.invalidResponse))
        return
      }

      guard (200..<300).contains(httpResponse.statusCode) else {
        completion(.failure(.httpError(code: httpResponse.statusCode)))
        return
      }

      guard let data = data else {
        completion(.failure(.noData))
        return
      }

      do {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let users = try decoder.decode([User].self, from: data)
        completion(.success(users))
      } catch {
        completion(.failure(.invalidData(message: error)))
      }
    }.resume()
  }
}
