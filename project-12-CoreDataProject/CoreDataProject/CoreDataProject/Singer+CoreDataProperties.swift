//
//  Singer+CoreDataProperties.swift
//  Singer
//
//  Created by Martin Rist on 20/08/2021.
//
//

import Foundation
import CoreData


extension Singer {

  @nonobjc public class func fetchRequest() -> NSFetchRequest<Singer> {
    return NSFetchRequest<Singer>(entityName: "Singer")
  }

  @NSManaged public var firstName: String?
  @NSManaged public var lastName: String?

  var wrappedFirstName: String {
    firstName ?? "Unknown"
  }

  var wrappedLastName: String {
    lastName ?? "Unknown"
  }

}

extension Singer : Identifiable {

}
