import Foundation
import SearchUI
import DI

class DetailViewModel<Api: IDetailApi>: IDetailViewModel {
    @Published var content: [IDetailViewModelItem] = []
    var contentPublisher: Published<[IDetailViewModelItem]>.Publisher { $content }
    
    @Injected private var api: Api!
    private let item: ViewModelItem
    
    public init(item: ViewModelItem) {
        self.item = item
    }
    
    func getDetails() {
        api.getDetails(forItem: item.apiItem) { [weak self] detaiApiItem, error in
            if let detaiApiItem = detaiApiItem {
                self?.content = self?.reduceItem(detaiApiItem) ?? []
            }
        }
    }
    
    func reduceItem(_ detailApiItem: IDetailApiItem) -> [IDetailViewModelItem] {
        return []
    }
}

public struct DetailViewModelItem: IDetailViewModelItem {
    public var title: String
    public var value: String
    
    public var id: String { return title }
}


