import SwiftUI

struct BookView: View {
    let module: String
    let books: [Book]
    let review: ReviewModel

    var body: some View {
        VStack {
            Text("Books for \(module)")
                .font(.title)
                .padding()

            List(books) { book in
                NavigationLink(destination: BookDetailsView(reviewModel: review, book: book)) {
                    VStack(alignment: .leading) {
                        Text(book.title)
                            .font(.headline)
                        Text(book.author)
                            .font(.subheadline)
                    }
                }

            }
        }
        .navigationBarTitle("Books", displayMode: .inline)
    }
}
