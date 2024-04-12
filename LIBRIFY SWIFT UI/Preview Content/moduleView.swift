import SwiftUI

struct ModulesView: View {
    let year: String
    let modules: [String]
    @ObservedObject var viewModel = BookViewModel()
    @State private var selectedModule: String?
    @StateObject private var reviewModel = ReviewModel()


    var body: some View {
        VStack {
            Text("Modules for \(year)")
                .font(.title)
                .padding()

            List(modules, id: \.self) { module in
                NavigationLink(destination: BookView(module: module, books: viewModel.books.filter { $0.module == module }, review: reviewModel),
                               tag: module,
                               selection: $selectedModule) {
                    Text(module)
                        .font(.headline)
                }
            }
        }
        .navigationBarTitle("Modules", displayMode: .inline)
        .onChange(of: selectedModule) { newModule in
            if let newModule = newModule {
                viewModel.fetchBooks(forModule: newModule)
            }
        }
    }
}
