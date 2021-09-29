import SwiftUI
import BooksApi

protocol AbstractApi {
    associatedtype Item: ViewModelItem
    associatedtype DetailItem: ViewModelDetailItem
    
    func makeSearch(query: String, batchSize: Int, startIndex: Int, completion: @escaping ([Item], Error?)-> Void)
    func getDetails(forItem: Item, completion: @escaping (DetailItem?, Error?) -> Void)
}

class ViewModel<Api: AbstractApi>: ObservableObject {
    
    let api: Api
    
    @Published var items: [Api.Item] = .init()
    @Published var detailItem: Api.DetailItem?
    
    init(api: Api) {
        self.api = api
    }
    
    func makeSearch(query: String) {
        self.items = []
        api.makeSearch(query: query, batchSize: 20, startIndex: 0) { [weak self] items, error in
            self?.items = items
        }
    }
    
    func getDetails(forItem: Api.Item) {
        self.detailItem = nil
        api.getDetails(forItem: forItem) { [weak self] detailItem, error in
            self?.detailItem = detailItem
        }
    }
}

protocol ViewModelItem: Identifiable {
    var title: String? { get }
    var id: String { get }
}

protocol ViewModelDetailItem: Identifiable {
    var content: [ViewModelDetailRow] { get }
    var id: String { get }
}

struct ViewModelDetailRow: Identifiable {
    var title: String
    var value: String
    
    var id: String { return title }
}
