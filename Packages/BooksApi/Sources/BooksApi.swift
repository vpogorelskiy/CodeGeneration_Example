public final class BooksApi: ObservableObject {
    private let apiKey = "AIzaSyByCbQHo0C1m92KdiAAMyqZaTar-mcVb4o"
    private let defaultBatchSize = 20
    
    @Published var bookVolumes: [BooksVolume] = []
    
    init(initalQuery: String, batchSize: Int = defaultBatchSize, startIndex: Int = 0) {
        BookVolumesAPI.getBooks(q: initalQuery,
                                key: apiKey,
                                printType: PrintType.books.rawValue,
                                startIndex: startIndex,
                                maxResults: batchSize,
                                apiResponseQueue: .main) { volumes, error in
            bookVolumes = volumes?.items ?? []
        }
    }
    
    // Fallback
    // Grid for iOS 13
}

private extension BooksApi {
    enum PrintType: String {
        case all
        case books
        case magazines
    }
}
