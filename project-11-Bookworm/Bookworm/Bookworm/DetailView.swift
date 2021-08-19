//
//  DetailView.swift
//  DetailView
//
//  Created by Martin Rist on 19/08/2021.
//

import SwiftUI
import CoreData

struct DetailView: View {
  
  @Environment(\.managedObjectContext) var moc
  @Environment(\.presentationMode) var presentationMode
  
  @State private var showingDeleteAlert = false
  
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

        let entered = book.date?.formatted() ?? "No date"
        Text("Entered at: \(entered)")
          .padding()

        Spacer()
      }
    }
    .navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .inline)
    .alert(isPresented: $showingDeleteAlert) {
      Alert(title: Text("Delete"),
            message: Text("Are you sure?"),
            primaryButton: .destructive(Text("Delete")) { deleteBook() },
            secondaryButton: .cancel())
    }
    .navigationBarItems(trailing: Button(action: {
      showingDeleteAlert = true
    }) {
      Image(systemName: "trash")
    })
  }
  
  func deleteBook() {
    moc.delete(book)
    try? moc.save()
    presentationMode.wrappedValue.dismiss()
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
