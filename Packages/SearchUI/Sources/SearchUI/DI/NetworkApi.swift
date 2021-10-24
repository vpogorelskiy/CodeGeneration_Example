
protocol DataSource {
    func loadData(forQuery: String, completion: @escaping ([FetchedData], Error?) -> Void)
}

protocol FetchedData {
    var title: String? { get }
}

