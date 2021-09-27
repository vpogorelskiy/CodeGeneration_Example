import SwiftUI
import BooksApi

struct BooksView: View {
    
    @EnvironmentObject var booksViewModel: BooksAPI
    
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
