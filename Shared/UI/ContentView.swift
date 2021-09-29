
import SwiftUI
import BooksApi
import MoviesApi

struct ContentView: View {
    
    @State private var bookSearchResult: String = ""
    private var booksViewModel: BooksAPI = .init()
    @State private var movieSearchResult: String = ""
    private var moviesViewModel: MoviesAPI = .init()
    
    var body: some View {
        TabView {
            NavigationView {
                SearchView(title: "Find books",
                           destination: ResultsView<BooksAPI>()
                            .environmentObject(booksViewModel)
                            .onAppear(perform: { booksViewModel.makeSearch(query: bookSearchResult) }),
                           searchResult: $bookSearchResult)
                    .navigationTitle("Books search")
            }
            .tabItem {
                Image(systemName: "books.vertical")
                Text("Results for '\(bookSearchResult)'")
            }
            NavigationView {
                SearchView(title: "Find movies",
                           destination: MoviesView()
                            .environmentObject(moviesViewModel)
                            .onAppear(perform: { moviesViewModel.makeSearch(query: movieSearchResult) }),
                           searchResult: $movieSearchResult)
                    .navigationTitle("Movies search")
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

extension BooksVolume: ViewModelItem {
    var title: String? {
        return volumeInfo.title
    }
}

extension VolumeInfo: ViewModelDetailItem {
    var content: [ViewModelDetailRow] {
        return []
    }
    
    public var id: String {
        return "\(hashValue)"
    }
}

extension BooksAPI: ViewModel {
    typealias Item = BooksVolume
    typealias DetailItem = VolumeInfo
    
    func getDetails(forItem: Item) {
        detailItem = forItem.volumeInfo
    }
}
