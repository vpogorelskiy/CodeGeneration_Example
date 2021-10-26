
public protocol AbstractApi {
    associatedtype Item: IViewModelItem
    associatedtype DetailItem: IViewModelDetailItem
    
    func makeSearch(query: String, batchSize: Int, startIndex: Int, completion: @escaping ([Item], Error?)-> Void)
    func getDetails(forItem: ApiItem, completion: @escaping (ApiDetailItem?, Error?) -> Void)
}

public protocol ApiItem {
    var id: String { get }
}

public protocol ApiDetailItem {
    var id: String { get }
    var content: [String: Any] { get }
}
