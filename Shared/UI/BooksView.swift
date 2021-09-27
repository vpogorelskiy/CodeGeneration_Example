import SwiftUI
import BooksApi

struct BooksView: View {
    @StateObject var booksViewModel: BooksAPI = BooksAPI(initalQuery: "Dune")
    
    var body: some View {
        NavigationView {
            List {
                ForEach(booksViewModel.bookVolumes) {
                    Text($0.volumeInfo.title)
                }
            }
            .navigationTitle("Books")
        }
    }
}

extension BooksVolume: Identifiable {}
