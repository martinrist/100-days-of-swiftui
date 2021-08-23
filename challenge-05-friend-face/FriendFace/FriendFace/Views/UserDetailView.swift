//
//  UserDetailView.swift
//  UserDetailView
//
//  Created by Martin Rist on 23/08/2021.
//

import SwiftUI

struct UserDetailView: View {

  let allUsers: [User]
  let user: User

  var body: some View {
    GeometryReader { geom in
      List {
        HStack(alignment: .center) {
          Spacer()
          UserIconView(userName: user.name)
            .frame(width: geom.size.width / 3, height: geom.size.width / 3)
            .padding([.top, .bottom], 16)
          Spacer()
        }

        Text(user.about)
          .multilineTextAlignment(.center)
          .lineLimit(nil)
          .padding(.top, 8)

        Section {
          UserInformationView(user: user)
        } header: {
          Text("User Information")
        }

        Section {
          FriendListView(allUsers: allUsers, friends: user.friends)
        } header: {
          Text("Friends")
        }

        Section {
          ForEach(user.tags, id: \.self) { tag in
            HStack {
              Spacer()
              UserTagView(tag: tag)
              Spacer()
            }
          }
        } header: {
          Text("Tags")
        }
      }
      .listStyle(.insetGrouped)
    }
    .navigationTitle(user.name)
  }
}

struct UserInformationView: View {
  let user: User

  var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .medium
    return formatter
  }

  var formattedRegistrationDate: String {
    dateFormatter.string(from: user.registered)
  }

  var body: some View {
    Group {
      HStack {
        Image(systemName: "network")
        Text(user.company)
      }

      HStack {
        Image(systemName: "map")
        Text(user.address)
      }

      HStack {
        Image(systemName: "envelope")
        Text(user.email)
      }

      HStack {
        Image(systemName: "gift")
        Text("\(user.age)")
      }

      HStack {
        Image(systemName: "calendar")
        Text(formattedRegistrationDate)
      }
    }
  }
}

struct FriendListView: View {
  let allUsers: [User]
  let friends: [Friend]

  func user(for friend: Friend) -> User? {
    allUsers.first { $0.id == friend.id }
  }

  var body: some View {
    ForEach(friends) { friend in
      if let user = user(for: friend) {
        NavigationLink(destination: UserDetailView(allUsers: allUsers, user: user)) {
          Text(friend.name)
        }
      } else {
        Text(friend.name)
      }
    }
  }
}

struct UserDetailView_Previews: PreviewProvider {
  static var previews: some View {
    let testUser = User(
      id: UUID(),
      name: "Martin Wilson",
      company: "MyCorp",
      address: "232 Saratoga Avenue East, NY 12345",
      email: "martin.wilson@mycorp.com",
      isActive: true,
      about:
      """
      Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.\r\n
      """,
      tags: ["Tag 1", "Tag 2", "Tag 3"],
      age: 23,
      registered: Date(),
      friends: []
    )
    UserDetailView(allUsers: [testUser], user: testUser)
  }
}
