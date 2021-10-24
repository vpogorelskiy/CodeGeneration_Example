import SwiftUI
import BooksApi

protocol AbstractViewModel {
    var items: [ViewModelItem] { get }
    func makeSearch(query: String)
    func loadNextIfNeeded(for: ViewModelItem)
    func detailViewModel(for: ViewModelItem) -> DetailViewModel
}

protocol DetailViewModel: AnyObject {
    var content: [ViewModelDetailRow] { get }
    func getDetails(for: ViewModelItem)
}

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
    @Published var isLoading = false
    
    private let batchSize = 20
    private var lastQuery = ""
    private var lastBatchIndex = 0
    private var hasNext = true
    
    init(api: Api) {
        self.api = api
    }
    
    func makeSearch(query: String) {
        guard query != lastQuery else { return }
        lastQuery = query
        lastBatchIndex = 0
        isLoading = true
        hasNext = true
        self.items = []
        api.makeSearch(query: query, batchSize: batchSize, startIndex: lastBatchIndex) { [weak self] items, error in
            self?.items = items
            self?.isLoading = false
        }
    }
    
    func loadNextIfNeeded(for item: Api.Item) {
        guard isLoading == false,
                hasNext == true,
                items.last?.id == item.id else { return }
        
        isLoading = true
        lastBatchIndex += 1
        api.makeSearch(query: lastQuery, batchSize: batchSize, startIndex: lastBatchIndex) { [weak self] items, error in
            self?.items.append(contentsOf: items)
            if items.isEmpty {
                self?.hasNext = false
            }
            self?.isLoading = false
        }
    }
    
    func getDetails(forItem: Api.Item) {
        self.detailItem = nil
        api.getDetails(forItem: forItem) { [weak self] detailItem, error in
            self?.detailItem = detailItem
        }
    }
}

protocol ViewModelItem {
    var title: String { get }
    var id: String { get }
}

protocol ViewModelDetailItem {
    var content: [ViewModelDetailRow] { get }
    var id: String { get }
}

struct ViewModelDetailRow: Identifiable {
    var title: String
    var value: String
    
    var id: String { return title }
}
