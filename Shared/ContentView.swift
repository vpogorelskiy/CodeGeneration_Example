
import SwiftUI
import BooksApi

struct ContentView: View {
    
    @StateObject var booksViewModel: BooksAPI = BooksAPI(initalQuery: Constants.initialQuery)
    
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
                        ForEach(booksViewModel.bookVolumes) {
                            Text($0.volumeInfo.title)
                        }
                    }
                    .navigationTitle(Constants.initialQuery)
            }.tabItem { Text("Native") }
        }
    }
}

private extension ContentView {
    enum Constants {
        static let initialQuery = "1984"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension BooksVolume: Identifiable {}
