import Foundation
import SearchUI

class ViewModel<Api: AbstractApi>: IViewModel {
    @Published var items: [IViewModelItem] = []
    
    func detailViewModel(for item: IViewModelItem) -> IDetailViewModel {
        return DetailViewModel(api: api,
                               item: item as! ViewModelItem)
    }
    
    
    @Published var isLoading = false
    
    private let api: Api
    private let batchSize = 20
    private var lastQuery = ""
    private var lastBatchIndex = 0
    private var hasNext = true
    
    public init(api: Api) {
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
            self?.items = self?.reduceItems(items) ?? []
            self?.isLoading = false
        }
    }
    
    func reduceItems(_ apiItems: [ApiItem]) -> [ViewModelItem] {
        // TODO: Implement!!!
        return []
    }
    
    func loadNextIfNeeded(for item: IViewModelItem) {
        guard isLoading == false,
                hasNext == true,
                items.last?.id == item.id else { return }
        
        isLoading = true
        lastBatchIndex += 1
        api.makeSearch(query: lastQuery, batchSize: batchSize, startIndex: lastBatchIndex) { [weak self] apiItems, error in
            let reducedItems = self?.reduceItems(apiItems) ?? []
            self?.items.append(contentsOf: reducedItems)
            if reducedItems.isEmpty {
                self?.hasNext = false
            }
            self?.isLoading = false
        }
    }
}

struct ViewModelItem: IViewModelItem {
    var id: String
    let title: String
    let apiItem: ApiItem
}

