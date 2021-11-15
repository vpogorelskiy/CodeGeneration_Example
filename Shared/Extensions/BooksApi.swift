import BooksApi
import SearchUI

extension BooksAPI: IApi {
    public func makeSearch(query: String, batchSize: Int, startIndex: Int, completion: @escaping ([IApiItem], Error?) -> Void) {
        perform(query: query, batchSize: batchSize, startIndex: startIndex) { bookVolumes, error in
            completion(bookVolumes, error)
        }
    }
}

extension BooksAPI: IDetailApi {
    public func getDetails(forItem: IApiItem, completion: (IDetailApiItem?, Error?) -> Void) {
        guard let item = forItem as? BooksVolume else {
            completion(nil, nil)
            return
        }
        
        completion(item.volumeInfo, nil)
    }
}

extension BooksVolume: IApiItem {
    var title: String? {
        return volumeInfo.title
    }
}

extension VolumeInfo: IDetailApiItem {
    public var id: String {
        return "\(hashValue)"
    }
}
