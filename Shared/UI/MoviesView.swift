import SwiftUI
import MoviesApi

struct MoviesView: View {
    @EnvironmentObject var moviesViewModel: MoviesAPI
    
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
