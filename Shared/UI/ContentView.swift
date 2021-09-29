
import SwiftUI
import BooksApi
import MoviesApi

struct ContentView: View {
    
    @State private var bookSearchResult: String = ""
    private var booksViewModel = ViewModel(api: BooksAPI())
    
    @State private var movieSearchResult: String = ""
    private var moviesViewModel = ViewModel(api: MoviesAPI())
    
    var body: some View {
        TabView {
            NavigationView {
                SearchView(title: "Find books",
                           destination: ResultsView<BooksAPI>()
                            .environmentObject(booksViewModel)
                            .onAppear(perform: { booksViewModel.makeSearch(query: bookSearchResult) }),
                           searchResult: $bookSearchResult)
                    .navigationTitle("Results for '\(bookSearchResult)'")
            }
            .tabItem {
                Image(systemName: "books.vertical")
                Text("Books")
            }
            NavigationView {
                SearchView(title: "Find movies",
                           destination: ResultsView<MoviesAPI>()
                            .environmentObject(moviesViewModel)
                            .onAppear(perform: { moviesViewModel.makeSearch(query: movieSearchResult) }),
                           searchResult: $movieSearchResult)
                    .navigationTitle("Results for '\(movieSearchResult)'")
            }
            .tabItem {
                Image(systemName: "play.rectangle")
                Text("Movies")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SearchView<Destination : View>: View {
    
    var title: String
    var destination: Destination
    
    @Binding var searchResult: String
    
    var body: some View {
        VStack {
            TextField("Search query",
                      text: $searchResult)
                .multilineTextAlignment(.center)
            Spacer().frame(height: 44)
            NavigationLink(destination: destination) {
                Text("Search")
            }
        }
    }
}
