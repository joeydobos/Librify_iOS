import Foundation

struct Book: Codable, Identifiable {
    let _id: String
    let title: String
    let author: String
    let description: String?
    let publicationYear: Int
    let publisher: String
    let isbn: String
    let year: Int
    let module: String
    let slug: String
    let price: Int?

    var id: String { _id }
}

struct BooksData: Codable {
    let books: [Book]
}

struct BooksResponse: Codable {
    let status: String
    let data: BooksData
}

class BookViewModel: ObservableObject {
    @Published var books: [Book] = []

    func fetchBooks(forModule module: String) {
        print(module)
        guard let booksURL = URL(string: "http://127.0.0.1:3000/api/v1/books/module/\(module)") else {
            print("Invalid URL")
            return
        }
        
        print(booksURL)

        URLSession.shared.dataTask(with: booksURL) { [weak self] data, response, error in
            guard let self = self else { return }

            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid HTTP response")
                return
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                print("HTTP Error: \(httpResponse.statusCode)")
                return
            }

            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(BooksResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.books = decodedResponse.data.books
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else {
                print("No data received")
            }
        }.resume()
    }
}
