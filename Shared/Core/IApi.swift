
public protocol IApi {
    func makeSearch(query: String, batchSize: Int, startIndex: Int, completion: @escaping ([IApiItem], Error?)-> Void)
}

public protocol IDetailApi {
    func getDetails(forItem: IApiItem, completion: @escaping (IDetailApiItem?, Error?) -> Void)
}

public protocol IApiItem {
    var id: String { get }
}

public protocol IDetailApiItem {
    var id: String { get }
}
