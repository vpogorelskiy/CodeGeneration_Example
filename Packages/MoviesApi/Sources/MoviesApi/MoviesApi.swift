import Foundation

open class MoviesAPI: ObservableObject {
    private let apiKey = "58955fe7"
    
    @Published public var movies: [MovieShort] = []
    @Published public var detailedMovie: MovieFull = .empty
    
    public init() {}
    
    public func makeSearch(query: String, page: Int = 1) {
        MoviesSearchAPI.getMovies(s: query, apiKey: apiKey) { [weak self] response, error in
            self?.movies = response?.search ?? []
        }
    }
    
    public func getMovieDetails(id: String) {
        detailedMovie = .empty
        MovieDetailsAPI.getMovieDetails(i: id, apiKey: apiKey) { [weak self] movie, error in
            if let movie = movie {
                self?.detailedMovie = movie
            }
        }
    }
}

extension MovieShort: Identifiable {
    public var id: String {
        return imdbID
    }
}

extension MovieFull {
    static var empty: MovieFull { return .init(title: "", imdbID: "") }
}
