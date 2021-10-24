
import SwiftUI
import BooksApi
import MoviesApi
import CustomNavigation
import SearchUI

struct ContentView: View {
    
    @State private var bookSearchResult: String = ""
    private var booksViewModel = ViewModel(api: BooksAPI())
    
    @State private var movieSearchResult: String = ""
    private var moviesViewModel = ViewModel(api: MoviesAPI())
    
    var body: some View {
        TabView {
//            CustomNavigation.NavigationView {
//                SearchView(searchResult: $bookSearchResult,
//                           destination: ResultsView<BooksAPI>()
//                            .environmentObject(booksViewModel)
//                            .onAppear(perform: { booksViewModel.makeSearch(query: bookSearchResult) })
//                            .customNavigationTitle("Results for '\(bookSearchResult)'"))
//                    .customNavigationTitle("Find books")
//            }
//            .tabItem {
//                Image(systemName: "books.vertical")
//                Text("Books")
//            }
//            CustomNavigation.NavigationView {
//                SearchView(searchResult: $movieSearchResult,
//                           destination: ResultsView<MoviesAPI>()
//                            .environmentObject(moviesViewModel)
//                            .onAppear(perform: { moviesViewModel.makeSearch(query: movieSearchResult) })
//                            .customNavigationTitle("Results for '\(movieSearchResult)'"))
//                    .customNavigationTitle("Find movies")
//            }
//            .tabItem {
//                Image(systemName: "play.rectangle")
//                Text("Movies")
//            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//struct SearchView<Destination : View>: View {
//
//    @Binding var searchResult: String
//    var destination: Destination
//
//    var body: some View {
//        VStack {
//            TextField("Search query",
//                      text: $searchResult)
//                .multilineTextAlignment(.center)
//            Spacer().frame(height: 44)
//            CustomNavigation.Link(destination: { destination },
//                                  label: { Text("Search") })
//        }
//    }
//}
