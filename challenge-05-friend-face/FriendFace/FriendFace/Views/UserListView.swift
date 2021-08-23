//
//  ContentView.swift
//  FriendFace
//
//  Created by Martin Rist on 23/08/2021.
//

import SwiftUI

struct UserListView: View {

  @ObservedObject var model: Model

  @State private var hideInactive = false

  private var filteredUsers: [User] {
    if hideInactive {
      return model.users.filter { $0.isActive }
    } else {
      return model.users
    }
  }


  var body: some View {
    NavigationView {
      List(filteredUsers) { user in
        UserListRow(user: user)
      }
      .navigationTitle("FriendFace")
      .navigationBarItems(trailing:
                            Button(hideInactive ? "Show Inactive" : "Hide Inactive") {
        hideInactive.toggle()
      })
    }
    .onAppear(perform: model.loadData)
  }
}

struct UserListRow: View {
  let user: User

  var body: some View {
    NavigationLink(destination: UserDetailView(user: user)) {

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
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    return UserListView(model: Model(dataLoader: TestDataLoader()))
  }
}
