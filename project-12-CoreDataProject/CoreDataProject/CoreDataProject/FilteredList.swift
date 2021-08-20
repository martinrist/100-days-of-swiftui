//
//  FilteredList.swift
//  FilteredList
//
//  Created by Martin Rist on 20/08/2021.
//

import CoreData
import SwiftUI

struct FilteredList: View {
  var fetchRequest: FetchRequest<Singer>

  var body: some View {
    List(fetchRequest.wrappedValue, id: \.self) { singer in
      Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
    }
  }

  init(filter: String) {
    fetchRequest = FetchRequest<Singer>(
      entity: Singer.entity(),
      sortDescriptors: [],
      predicate: NSPredicate(format: "lastName BEGINSWITH %@", filter))
  }
}
