import Foundation
import SearchUI
import DI

class DetailViewModel<Api: AbstractDetailApi>: IDetailViewModel {
    @Published var content: [String: String] = [:]
    var contentPublisher: Published<[String: String]>.Publisher { $content }
    
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


