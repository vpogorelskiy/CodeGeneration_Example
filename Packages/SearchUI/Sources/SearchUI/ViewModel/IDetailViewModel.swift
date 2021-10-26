import Foundation

protocol IDetailViewModel: AnyObject {
    var content: [ViewModelDetailRow] { get }
    func getDetails()
}

public protocol IViewModelDetailItem {
    var content: [ViewModelDetailRow] { get }
    var id: String { get }
}

class DetailViewModel<Api: AbstractApi>: IDetailViewModel {
    let api: Api
    private let item: ViewModelItem
    
    var detailItem: ApiDetailItem?
    var content: [ViewModelDetailRow] = []
    
    public init(api: Api, item: ViewModelItem) {
        self.api = api
        self.item = item
    }
    
    func getDetails() {
        api.getDetails(forItem: item.apiItem) { [weak self] detaiApilItem, error in
            self?.detailItem = detaiApilItem
        }
    }
}


public struct ViewModelDetailRow: Identifiable {
    var title: String
    var value: String
    
    public var id: String { return title }
}
