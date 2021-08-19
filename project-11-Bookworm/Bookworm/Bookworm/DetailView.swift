//
//  DetailView.swift
//  DetailView
//
//  Created by Martin Rist on 19/08/2021.
//

import SwiftUI
import CoreData

struct DetailView: View {
  let book: Book

  var body: some View {
    GeometryReader { geometry in
      VStack {
        ZStack(alignment: .bottomTrailing) {
          Image(book.genre ?? "Fantasy")
            .frame(maxWidth: geometry.size.width)

          Text(book.genre?.uppercased() ?? "FANTASY")
            .font(.caption)
            .fontWeight(.black)
            .padding(8)
            .foregroundColor(.white)
            .background(Color.black.opacity(0.75))
            .clipShape(Capsule())
            .offset(x: -5, y: -5)
        }

        Text(book.author ?? "Unknown author")
          .font(.title)
          .foregroundColor(.secondary)

        Text(book.review ?? "No review")
          .padding()

        RatingView(rating: .constant(Int(book.rating)))
          .font(.largeTitle)

        Spacer()
      }
    }
    .navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .inline)
  }
}

struct DetailView_Previews: PreviewProvider {
  static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

  static var previews: some View {
    let book = Book(context: moc)
    book.title = "Test book"
    book.author = "Test author"
    book.genre = "Fantasy"
    book.rating = 4
    book.review = "This is a great book - I really enjoyed it!"

    return NavigationView {
      DetailView(book: book)
    }
  }
}
