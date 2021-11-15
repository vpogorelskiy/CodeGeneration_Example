
public protocol AbstractApi {
    func makeSearch(query: String, batchSize: Int, startIndex: Int, completion: @escaping ([ApiItem], Error?)-> Void)
}

public protocol AbstractDetailApi {
    func getDetails(forItem: ApiItem, completion: @escaping (ApiDetailItem?, Error?) -> Void)
}

public protocol ApiItem {
    var id: String { get }
}

public protocol ApiDetailItem {
    var id: String { get }
}
