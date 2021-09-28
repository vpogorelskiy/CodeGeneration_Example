import Foundation

open class BooksAPI: ObservableObject {
    private let apiKey = "AIzaSyByCbQHo0C1m92KdiAAMyqZaTar-mcVb4o"
    
    @Published public var bookVolumes: [BooksVolume] = []
    
    public init() {}
    
    public func makeSearch(query: String, batchSize: Int = 20,
                           startIndex: Int = 0) {
        BookVolumesAPI.getBooks(q: query,
                                key: apiKey,
                                printType: PrintType.books.rawValue,
                                startIndex: startIndex,
                                maxResults: batchSize,
                                apiResponseQueue: .main) { [weak self] volumes, error in
            print("ApiDebug.\(Self.self).\(#function): Response: \(volumes); Error: \(error)")
            self?.bookVolumes = volumes?.items ?? []
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
