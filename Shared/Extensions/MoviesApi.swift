import MoviesApi
import SearchUI

extension MoviesAPI: IApi {
    public func makeSearch(query: String, batchSize: Int, startIndex: Int, completion: @escaping ([IApiItem], Error?) -> Void) {
        perform(query: query, batchSize: batchSize, startIndex: startIndex) { movieItems, error in
            completion(movieItems, error)
        }
    }
}

extension MoviesAPI: IDetailApi {
    public func getDetails(forItem: IApiItem, completion: @escaping (IDetailApiItem?, Error?) -> Void) {
        guard let item = forItem as? MovieShort else {
            completion(nil, nil)
            return
        }
        getMovieDetails(for: item, completion: completion)
    }
}


extension MovieShort: IApiItem {}

extension MovieFull: IDetailApiItem {
    public var id: String {
        return "\(hashValue)"
    }
}
