
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ViewBuilder.booksView()
                .tabItem {
                    Image(systemName: "books.vertical")
                    Text("Books")
                }
            ViewBuilder.moviesView()
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
