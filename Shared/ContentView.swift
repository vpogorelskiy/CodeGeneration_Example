
import SwiftUI
import BooksApi

struct ContentView: View {
     
    var body: some View {
        TabView {
            BooksView()
                .tabItem {
                Image(systemName: "books.vertical")
                Text("Books")
            }
            MoviesView().tabItem {
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

private extension ContentView {
    enum Constants {
        static let initialQuery = "1984"
    }
}
