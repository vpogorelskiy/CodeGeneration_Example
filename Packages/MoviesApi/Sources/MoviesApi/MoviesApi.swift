import Foundation

open class MoviesAPI: ObservableObject {
    private let apiKey = "58955fe7"
    
    @Published public var movies: [MovieShort] = []
    @Published public var detailedMovie: MovieFull = .empty
    
    public init() {}
    
    public func perform(query: String, batchSize: Int, startIndex: Int, completion: @escaping ([MovieShort], Error?)-> Void) {
        MoviesSearchAPI.getMovies(s: query, apiKey: apiKey, page: startIndex + 1) { response, error in
            completion(response?.search ?? [], error)
        }
    }
    
    public func getMovieDetails(for movie: MovieShort, completion: @escaping (MovieFull?, Error?) -> Void) {
        detailedMovie = .empty
        MovieDetailsAPI.getMovieDetails(i: movie.imdbID, apiKey: apiKey) { movie, error in
            completion(movie, error)
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
