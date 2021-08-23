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
      VStack(alignment: .center) {
        UserIconView(userName: user.name)
          .frame(width: geom.size.width / 3, height: geom.size
                  .width / 3)
        Text(user.about)
          .padding(32)
          .multilineTextAlignment(.center)

        Spacer()
      }
      .padding()
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
      """
    )
    UserDetailView(user: testUser)
  }
}
