
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
                SearchView(searchResult: $bookSearchResult,
                           destination: ResultsView<BooksAPI>()
                            .environmentObject(booksViewModel)
                            .onAppear(perform: { booksViewModel.makeSearch(query: bookSearchResult) })
                            .navigationTitle("Results for '\(bookSearchResult)'"))
                    .navigationTitle("Find books")
            }
            .tabItem {
                Image(systemName: "books.vertical")
                Text("Books")
            }
            NavigationView {
                SearchView(searchResult: $movieSearchResult,
                           destination: ResultsView<MoviesAPI>()
                            .environmentObject(moviesViewModel)
                            .onAppear(perform: { moviesViewModel.makeSearch(query: movieSearchResult) })
                            .navigationTitle("Results for '\(movieSearchResult)'"))
                    .navigationTitle("Find movies")
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
    
    @Binding var searchResult: String
    var destination: Destination
    
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
