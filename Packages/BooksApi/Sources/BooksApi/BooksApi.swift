import Foundation

open class BooksAPI: ObservableObject {
    private let apiKey = "AIzaSyByCbQHo0C1m92KdiAAMyqZaTar-mcVb4o"
    
    public init() {}
    
    public func makeSearch(query: String, batchSize: Int, startIndex: Int, completion: @escaping ([BooksVolume], Error?) -> Void) {
        BookVolumesAPI.getBooks(q: query,
                                key: apiKey,
                                printType: PrintType.books.rawValue,
                                startIndex: startIndex * batchSize - 1,
                                maxResults: batchSize,
                                apiResponseQueue: .main) { [weak self] volumes, error in
            completion(volumes?.items ?? [], error)
        }
    }
}

private extension BooksAPI {
    enum PrintType: String {
        case all
        case books
        case magazines
    }
}
