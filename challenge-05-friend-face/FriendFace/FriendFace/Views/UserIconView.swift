//
//  UserIconView.swift
//  UserIconView
//
//  Created by Martin Rist on 23/08/2021.
//

import SwiftUI

struct UserIconView: View {

  let userName: String

  var body: some View {
    let initials = userName.split(separator: " ")
      .compactMap { $0.first?.uppercased() }
      .joined()

    return GeometryReader { geom in
      ZStack {
        Circle()
          .fill(.gray)

        Text(initials)
          .padding(geom.size.width / 10)
          .font(.system(size: 1000))
          .minimumScaleFactor(0.001)
          .foregroundColor(.white)
      }
    }
  }
}

struct UserIconView_Previews: PreviewProvider {
  static var previews: some View {
    UserIconView(userName: "Martin Rist")
  }
}
