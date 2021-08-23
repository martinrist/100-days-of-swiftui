//
//  ContentView.swift
//  FriendFace
//
//  Created by Martin Rist on 23/08/2021.
//

import SwiftUI

struct UserListView: View {

  @ObservedObject var model: Model

  var body: some View {
    NavigationView {
      List(model.users) { user in
        Text(user.name)
      }
      .navigationTitle("FriendFace")
    }
    .onAppear(perform: model.loadData)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    return UserListView(model: Model(dataLoader: TestDataLoader()))
  }
}
