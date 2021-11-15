import BooksApi
import SearchUI

extension BooksAPI: AbstractApi {
    public func makeSearch(query: String, batchSize: Int, startIndex: Int, completion: @escaping ([ApiItem], Error?) -> Void) {
        perform(query: query, batchSize: batchSize, startIndex: startIndex) { bookVolumes, error in
            completion(bookVolumes, error)
        }
    }
}

extension BooksAPI: AbstractDetailApi {
    public func getDetails(forItem: ApiItem, completion: (ApiDetailItem?, Error?) -> Void) {
        guard let item = forItem as? BooksVolume else {
            completion(nil, nil)
            return
        }
        
        completion(item.volumeInfo, nil)
    }
}

extension BooksVolume: ApiItem {
    var title: String? {
        return volumeInfo.title
    }
}

extension VolumeInfo: ApiDetailItem {
    public var content: [String: String] {
        return ["Title" : title,
                "Authors": (authors ?? []).joined(separator: ", "),
                "Published on": publishedDate ?? "",
                "Launguage": language ?? "",
                "Description": description ?? ""
        ]
    }
    
    public var id: String {
        return "\(hashValue)"
    }
}
