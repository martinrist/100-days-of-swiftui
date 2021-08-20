//
//  FilteredList.swift
//  FilteredList
//
//  Created by Martin Rist on 20/08/2021.
//

import CoreData
import SwiftUI

enum Predicate: String {
  case equals = "=="
  case lessThan = "<"
  case greaterThan = ">"
  case `in` = "IN"
  case beginsWith = "BEGINSWITH"
  case beginsWithIgnoringCase = "BEGINSWITH[c]"
  case contains = "CONTAINS"
  case containsIgnoringCase = "CONTAINS[c]"
}

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
       predicate: Predicate,
       filterValue: String,
       sortDescriptors: [NSSortDescriptor] = [],
       @ViewBuilder content: @escaping (T) -> Content) {

    fetchRequest = FetchRequest<T>(
      entity: T.entity(),
      sortDescriptors: sortDescriptors,
      predicate: NSPredicate(format: "%K \(predicate.rawValue) %@",
                             filterKey,
                             filterValue))
    self.content = content
  }
}
