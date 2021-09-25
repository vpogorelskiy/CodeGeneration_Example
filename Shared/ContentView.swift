
import SwiftUI
import BooksApi

struct ContentView: View {
    
    @StateObject var booksViewModel: BooksAPI = BooksAPI(initalQuery: "1984")
    
    var body: some View {
        TabView {
            CustomNavigation.NavigationView() {
                VStack{
                    Text("Nothing to see here yet")
                        .navigationTitle("Title")
                    Spacer().frame(height: 44)
                    NavigationLink("Go Custom way", destination: Text("Navigated to custom view"))
                }
            }.tabItem { Text("Custom") }
            
            NavigationView {
                
                    List {
//                        ForEach(listViewModel.newsList) {
//                            ArticleCellView(title: $0.title ?? "no title")
//                        }
                    }
                    .navigationTitle("Native navigation")
            }.tabItem { Text("Native") }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
