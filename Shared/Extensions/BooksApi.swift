import BooksApi
import SearchUI

extension BooksAPI: AbstractApi {
//    typealias Item = BooksVolume
//    typealias DetailItem = VolumeInfo
    
    func getDetails(forItem: ApiItem, completion: (DetailItem?, Error?) -> Void) {
        completion(forItem.id, nil)
    }
}

extension BooksVolume: ViewModelItem {
    var title: String? {
        return volumeInfo.title
    }
}

extension VolumeInfo: ViewModelDetailItem {
    var content: [ViewModelDetailItem] {
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
