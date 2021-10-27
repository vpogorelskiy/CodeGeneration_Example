import Foundation
import SearchUI

class DetailViewModel<Api: AbstractApi>: IDetailViewModel {
    var content: [String: String] = [:]
    
    private let api: Api
    private let item: ViewModelItem
    
    public init(api: Api, item: ViewModelItem) {
        self.api = api
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


