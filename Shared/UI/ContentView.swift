
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ViewBuilder.booksView()
                .tabItem {
                    Image(systemName: "books.vertical")
                    Text("Books")
                }
            ViewBuilder.booksOfflineView()
                .tabItem {
                    Image(systemName: "bookmark.fill")
                    Text("Books offline")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
