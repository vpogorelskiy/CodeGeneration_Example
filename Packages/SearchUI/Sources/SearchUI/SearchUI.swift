import SwiftUI
import CustomNavigation

public struct SearchUI {}

public struct SearchUIView {
    
    @State private var searchResult: String = ""
    
    var viewModel: AbstractViewModel
    
    var body: some View {
        CustomNavigation.NavigationView {
            SearchView(searchResult: $searchResult,
                       destination: ResultsView<BooksAPI>()
                        .environmentObject(viewModel)
                        .onAppear(perform: { viewModel.makeSearch(query: $searchResult) })
                        .customNavigationTitle("Results for '\($searchResult)'"))
                .customNavigationTitle("Find books")
        }
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
            CustomNavigation.Link(destination: { destination },
                                  label: { Text("Search") })
        }
    }
}

