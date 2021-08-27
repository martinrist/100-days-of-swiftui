//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Martin Rist on 23/08/2021.
//

import SwiftUI

@main
struct FriendFaceApp: App {
  var body: some Scene {
    WindowGroup {
      UserListView(model: Model())
    }
  }
}
