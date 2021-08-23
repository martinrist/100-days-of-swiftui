//
//  UserDetailView.swift
//  UserDetailView
//
//  Created by Martin Rist on 23/08/2021.
//

import SwiftUI

struct UserDetailView: View {

  let user: User

  var body: some View {
    GeometryReader { geom in
      ScrollView {
        VStack(alignment: .center) {
          UserIconView(userName: user.name)
            .frame(width: geom.size.width / 3, height: geom.size
                    .width / 3)

          Text(user.about)
            .padding(32)
            .multilineTextAlignment(.center)

          VStack(alignment: .leading) {
            HStack {
              Image(systemName: "network")
              Text(user.company)
            }
            .padding(.bottom)

            HStack {
              Image(systemName: "map")
              Text(user.address)
            }
            .padding(.bottom)

            HStack {
              Image(systemName: "gift")
              Text("\(user.age)")
            }
            .padding(.bottom)

            
          }

          VStack {
            ForEach(user.tags, id: \.self) { tag in
              UserTagView(tag: tag)
            }
          }.padding()
        }
        .padding()
      }
    }
    .navigationTitle(user.name)
  }
}

struct UserDetailView_Previews: PreviewProvider {
  static var previews: some View {
    let testUser = User(
      id: UUID(),
      name: "Martin Wilson",
      company: "MyCorp",
      address: "232 Saratoga Avenue East, NY 12345",
      isActive: true,
      about:
      """
      Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.\r\n
      """,
      tags: ["Tag 1", "Tag 2", "Tag 3"],
      age: 23
    )
    UserDetailView(user: testUser)
  }
}
