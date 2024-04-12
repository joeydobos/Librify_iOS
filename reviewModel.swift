import Foundation

struct Review: Codable {
    let _id: String
    let user: String
    let book: String
    let rating: Int
    let comment: String
    let timestamp: String
    let __v: Int
}

struct ReviewsData: Codable {
    let reviews: [Review]
    let averageRating: Double
}

struct ReviewsResponse: Codable {
    let status: String
    let data: ReviewsData
}

class ReviewModel: ObservableObject {
    @Published var reviews: [Review] = []
    @Published var averageRating: Double = 0.0

    func fetchReviews(forBookSlug slug: String) {
        guard let reviewsURL = URL(string: "http://127.0.0.1:3000/api/v1/reviews/book/\(slug)/reviews") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: reviewsURL) { [weak self] data, response, error in
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
                    let decodedResponse = try JSONDecoder().decode(ReviewsResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.reviews = decodedResponse.data.reviews
                        self.averageRating = decodedResponse.data.averageRating
                        
                        // Print the retrieved data
                        print("Reviews retrieved:")
                        for review in self.reviews {
                            print(review)
                        }
                        print("Average rating: \(self.averageRating)")
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
