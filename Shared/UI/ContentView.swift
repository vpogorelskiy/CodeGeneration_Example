
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

extension BooksVolume: ViewModelItem {
    var title: String? {
        return volumeInfo.title
    }
}

extension VolumeInfo: ViewModelDetailItem {
    var content: [ViewModelDetailRow] {
        return [.init(title: "Title", value: title),
                .init(title: "Authors", value: (authors ?? []).joined(separator: ", ")),
                .init(title: "Published on", value: publishedDate.safeString),
                .init(title: "Launguage", value: language.safeString),
                .init(title: "Description", value: description.safeString)
        ]
    }
    
    public var id: String {
        return "\(hashValue)"
    }
}

extension BooksAPI: AbstractApi {
    typealias Item = BooksVolume
    typealias DetailItem = VolumeInfo
    
    func getDetails(forItem: Item, completion: (DetailItem?, Error?) -> Void) {
        completion(forItem.volumeInfo, nil)
    }
}

extension MoviesAPI: AbstractApi {
    typealias Item = MovieShort
    typealias DetailItem = MovieFull
}

extension MovieShort: ViewModelItem {}

extension MovieFull: ViewModelDetailItem {
    var content: [ViewModelDetailRow] {
        return [.init(title: "Title", value: title),
                .init(title: "Year", value: released.safeString),
                .init(title: "Actors", value: actors.safeString),
                .init(title: "Launguage", value: language.safeString),
                .init(title: "Description", value: plot.safeString)
        ]
    }
    
    public var id: String {
        return "\(hashValue)"
    }
}
