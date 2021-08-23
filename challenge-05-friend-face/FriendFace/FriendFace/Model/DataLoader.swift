//
//  DataLoader.swift
//  DataLoader
//
//  Created by Martin Rist on 23/08/2021.
//

import Foundation

enum DataLoadError: Error {
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
      User(id: UUID(), name: "Martin"),
      User(id: UUID(), name: "Sally"),
      User(id: UUID(), name: "David")
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
        let users = try JSONDecoder().decode([User].self, from: data)
        completion(.success(users))
      } catch {
        completion(.failure(.invalidData(message: error)))
      }
    }.resume()
  }
}
