import SwiftUI
import SearchUI
import DI
import BooksApi
import MoviesApi

enum ViewBuilder {
    static func registerDependencies() {
        Resolver.sharedInstance.register(BooksAPI.self) { r in
            BooksAPI()
        }
        
        Resolver.sharedInstance.register(MoviesAPI.self) { r in
            MoviesAPI()
        }
    }
    
    
    static func booksView() -> some View {
        SearchUIView(viewModel: BooksViewModel())
    }
        
    static func moviesView() -> some View {
        SearchUIView(viewModel: MoviesViewModel())
    }
}
