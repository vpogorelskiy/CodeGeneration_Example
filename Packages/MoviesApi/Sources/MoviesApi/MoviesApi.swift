import Foundation

open class MoviesAPI: ObservableObject {
    private let apiKey = "58955fe7"
    
    @Published public var movies: [MovieShort] = []
    
    public init() {}
    
    public func makeSearch(query: String, page: Int = 1) {
        MoviesSearchAPI.getMovies(s: query, apiKey: apiKey) { [weak self] response, error in
            self?.movies = response?.search ?? []
            print("ApiDebug.\(Self.self).\(#function): Response: \(response); Error: \(error)")
        }
    }
}

extension MovieShort: Identifiable {
    public var id: String {
        return imdbID
    }
}
