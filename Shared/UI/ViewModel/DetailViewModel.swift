import Foundation
import SearchUI
import DI

class DetailViewModel<Api: AbstractDetailApi>: IDetailViewModel {
    var content: [String: String] = [:]
    
    @Injected private var api: Api!
    private let item: ViewModelItem
    
    public init(item: ViewModelItem) {
        self.item = item
    }
    
    func getDetails() {
        api.getDetails(forItem: item.apiItem) { [weak self] detaiApiItem, error in
            self?.content = detaiApiItem?.content ?? [:]
        }
    }
}

public struct ViewModelDetailItem: Identifiable {
    var title: String
    var value: String
    
    public var id: String { return title }
}


