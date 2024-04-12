//  bookDetailView.swift
//  LIBRIFY SWIFT UI
//
//  Created by Joseph Dobos on 27/03/2024.
//
import SwiftUI

struct BookDetailsView: View {
    @ObservedObject var reviewModel: ReviewModel
    let book: Book
    let pink = Color(red: 242 / 255, green: 132 / 255, blue: 158 / 255)
    let grey = Color(red: 122 / 255, green: 122 / 255, blue: 122 / 255)
    let boxColours: [Color] = [
        Color(red: 242 / 255, green: 132 / 255, blue: 158 / 255),
        Color(red: 126 / 255, green: 202 / 255, blue: 246 / 255),
        Color(red: 123 / 255, green: 208 / 255, blue: 193 / 255),
        Color(red: 199 / 255, green: 91 / 255, blue: 155 / 255),
        Color(red: 174 / 255, green: 133 / 255, blue: 202 / 255),
        Color(red: 132 / 255, green: 153 / 255, blue: 231 / 255)
    ]
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Image("book")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding(.top)

                Text(book.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(pink)

                Divider()

                Text("Average Rating: ").foregroundColor(grey) + Text("\(String(format: "%.1f", reviewModel.averageRating))").foregroundColor(pink)

                Divider()

                VStack(alignment: .leading, spacing: 8) {
                    Text("Book Description")
                        .font(.headline)
                        .foregroundColor(pink)
                        .padding(.bottom, 2)

                    Text(book.description ?? "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.")
                        .font(.body)
                        .foregroundColor(grey)
                }
                .padding(.vertical)

                Divider()

                Group {
                    DetailRow(title: "Title", value: book.title, pinkColor: pink, greyColor: grey)
                    DetailRow(title: "Author", value: book.author, pinkColor: pink, greyColor: grey)
                    DetailRow(title: "Publication Year", value: String(book.publicationYear), pinkColor: pink, greyColor: grey)
                    DetailRow(title: "Publisher", value: book.publisher, pinkColor: pink, greyColor: grey)
                    DetailRow(title: "ISBN", value: book.isbn, pinkColor: pink, greyColor: grey)
                    DetailRow(title: "Modules Used In", value: book.module, pinkColor: pink, greyColor: grey)
                    if let price = book.price {
                        DetailRow(title: "Price", value: "£\(price)", pinkColor: pink, greyColor: grey)
                    }
                }
                Divider()
                
                
                Text("Reviews")
                    .font(.headline)
                    .foregroundColor(pink)
                    .padding(.bottom, 2)

                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(reviewModel.reviews.indices, id: \.self) { index in
                        let review = reviewModel.reviews[index]
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(boxColours[index % boxColours.count])
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 150)
                            .overlay(
                                VStack {
                                    Text(review.comment)
                                        .foregroundColor(.white)
                                        .font(.headline)
                                        .padding(5)
                                    Text("Rating: \(review.rating)")
                                        .foregroundColor(.white)
                                        .font(.subheadline)
                                        .padding(5)
                                },
                                alignment: .center
                            )
                    }
                }

            }
            .padding()
        }
        .navigationBarTitle(Text("Book Details"), displayMode: .inline)
        .onAppear {
            reviewModel.fetchReviews(forBookSlug: book.slug)
        }
    }
}

struct DetailRow: View {
    var title: String
    var value: String
    var pinkColor: Color
    var greyColor: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .foregroundColor(pinkColor)
            Text(value)
                .font(.body)
                .foregroundColor(greyColor)
        }
        .padding(.vertical, 4)
    }
}
