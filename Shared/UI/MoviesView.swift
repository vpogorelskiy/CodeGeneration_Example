import SwiftUI
import MoviesApi

struct MoviesView: View {
//    @State var query: String
    @StateObject var moviesViewModel: MoviesAPI = MoviesAPI(initalQuery: "Dune")
    
    var body: some View {
        NavigationView {
            List {
                ForEach(moviesViewModel.movies) {
                    Text($0.title ?? "Not found")
                }
            }
            .navigationTitle("Movies")
        }
    }
}
