import MoviesApi
import SearchUI

extension MoviesAPI: AbstractApi {
    public func makeSearch(query: String, batchSize: Int, startIndex: Int, completion: @escaping ([ApiItem], Error?) -> Void) {
        perform(query: query, batchSize: batchSize, startIndex: startIndex) { movieItems, error in
            completion(movieItems, error)
        }
    }
}

extension MoviesAPI: AbstractDetailApi {
    public func getDetails(forItem: ApiItem, completion: @escaping (ApiDetailItem?, Error?) -> Void) {
        guard let item = forItem as? MovieShort else {
            completion(nil, nil)
            return
        }
        getMovieDetails(for: item, completion: completion)
    }
}


extension MovieShort: ApiItem {}

extension MovieFull: ApiDetailItem {
    public var content: [String: String] {
        return ["Title": title,
                "Year": released.safeString,
                "Actors": actors.safeString,
                "Launguage": language.safeString,
                "Description": plot.safeString
        ]
    }

    public var id: String {
        return "\(hashValue)"
    }
}
