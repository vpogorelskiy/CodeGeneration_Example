import Foundation

open class BooksAPI: ObservableObject {
    private let apiKey = "AIzaSyByCbQHo0C1m92KdiAAMyqZaTar-mcVb4o"
    
    @Published var bookVolumes: [BooksVolume] = []
    
    public init(initalQuery: String, batchSize: Int = 20,
                startIndex: Int = 0) {
        BookVolumesAPI.getBooks(q: initalQuery,
                                key: apiKey,
                                printType: PrintType.books.rawValue,
                                startIndex: startIndex,
                                maxResults: batchSize,
                                apiResponseQueue: .main) { [weak self] volumes, error in
            self?.bookVolumes = volumes?.items ?? []
        }
    }
    
    // Fallback
    // Grid for iOS 13
}

private extension BooksAPI {
    enum PrintType: String {
        case all
        case books
        case magazines
    }
}
