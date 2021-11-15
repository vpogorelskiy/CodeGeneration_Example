import Foundation
import DI
import SearchUI

class ViewModel<Api: IApi>: IViewModel {
    @Injected var api: Api!
    @Published var items: [IViewModelItem] = []
    @Published var isLoading = false
    
    var itemsPublisher: Published<[IViewModelItem]>.Publisher { $items }
    var isLoadingPublisher: Published<Bool>.Publisher { $isLoading }

    private let batchSize = 20
    private var lastQuery = ""
    private var lastBatchIndex = 0
    private var hasNext = true

    public init() {}

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

    func reduceItems(_ apiItems: [IApiItem]) -> [ViewModelItem] {
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
    
    func detailViewModel(for item: IViewModelItem) -> IDetailViewModel? {
        return nil
    }
}

struct ViewModelItem: IViewModelItem {
    var id: String
    let title: String
    let apiItem: IApiItem
}

