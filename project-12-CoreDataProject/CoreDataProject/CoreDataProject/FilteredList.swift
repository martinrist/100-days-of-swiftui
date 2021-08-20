//
//  FilteredList.swift
//  FilteredList
//
//  Created by Martin Rist on 20/08/2021.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
  var fetchRequest: FetchRequest<T>

  var singers: FetchedResults<T> {
    fetchRequest.wrappedValue
  }

  let content: (T) -> Content

  var body: some View {
    List(fetchRequest.wrappedValue, id: \.self) { singer in
      self.content(singer)
    }
  }

  init(filterKey: String,
       filterValue: String,
       sortDescriptors: [NSSortDescriptor] = [],
       predicate: String = "BEGINSWITH",
       @ViewBuilder content: @escaping (T) -> Content) {

    fetchRequest = FetchRequest<T>(
      entity: T.entity(),
      sortDescriptors: sortDescriptors,
      predicate: NSPredicate(format: "%K \(predicate) %@",
                             filterKey,
                             filterValue))
    self.content = content
  }
}
