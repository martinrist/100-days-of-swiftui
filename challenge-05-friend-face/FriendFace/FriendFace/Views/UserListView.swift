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
        UserListRow(user: user)
      }
      .navigationTitle("FriendFace")
    }
    .onAppear(perform: model.loadData)
  }
}

struct UserListRow: View {
  let user: User

  var body: some View {
    VStack(alignment: .leading) {
      Text(user.name)
        .padding(.bottom, 2)
      Group {
        HStack {
          Image(systemName: "map")
          Text(user.address)
        }
        HStack {
          Image(systemName: "network")
          Text(user.company)
        }
      }
      .font(.caption)
    }
    .foregroundColor(user.isActive ? .primary : .secondary)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    return UserListView(model: Model(dataLoader: TestDataLoader()))
  }
}
