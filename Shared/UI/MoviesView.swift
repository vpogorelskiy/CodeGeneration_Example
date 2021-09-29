import SwiftUI
import MoviesApi

struct MoviesView: View {
    @EnvironmentObject var moviesViewModel: MoviesAPI
    
    var body: some View {
        List {
            ForEach(moviesViewModel.movies) { movie in
                let title = movie.title.safeString
                NavigationLink {
                    MovieDetailView(detailInfo: $moviesViewModel.detailedMovie)
                        .onAppear {
//                            moviesViewModel.getDetails(forItem: movie, completion: {})
                        }
                } label: {
                    Text(title)
                }
            }
        }
        .navigationTitle("Movies")
    }
}

struct MovieDetailView: View {
    @Binding var detailInfo: MovieFull
    @State var image: Image? = nil
    
    enum Titles {
        static let title = "Title"
        static let actors = "Actors"
        static let plot = "Plot"
    }
    
    private var detailMap: [(String, String)] {
        return [(Titles.title, detailInfo.title),
                (Titles.actors, detailInfo.actors.safeString),
                (Titles.plot, detailInfo.plot.safeString)
        ]
    }
    
    var body: some View {
        List {
            ForEach(detailMap, id: \.0) { title in
                VStack(alignment: .leading) {
                    Text(title.0).font(.title)
                    Text(title.1)
                }
            }
        }
    }
}
