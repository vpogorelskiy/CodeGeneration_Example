import BooksApi

extension BooksAPI: AbstractApi {
    typealias Item = BooksVolume
    typealias DetailItem = VolumeInfo
    
    func getDetails(forItem: Item, completion: (DetailItem?, Error?) -> Void) {
        completion(forItem.volumeInfo, nil)
    }
}

extension BooksVolume: ViewModelItem {
    var title: String? {
        return volumeInfo.title
    }
}

extension VolumeInfo: ViewModelDetailItem {
    var content: [ViewModelDetailRow] {
        return [.init(title: "Title", value: title),
                .init(title: "Authors", value: (authors ?? []).joined(separator: ", ")),
                .init(title: "Published on", value: publishedDate.safeString),
                .init(title: "Launguage", value: language.safeString),
                .init(title: "Description", value: description.safeString)
        ]
    }
    
    public var id: String {
        return "\(hashValue)"
    }
}
