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
        
        Resolver.sharedInstance.register(EntityProvider.self) { r in
            EntityProvider()
        }
    }
    
    
    static func booksView() -> some View {
        SearchUIView(viewModel: BooksViewModel())
    }
    
    static func booksOfflineView() -> some View {
        let vm = BooksViewModel()
        vm.isOffline = true
        return SearchUIView(viewModel: vm)
    }
        
    static func moviesView() -> some View {
        SearchUIView(viewModel: MoviesViewModel())
    }
}
