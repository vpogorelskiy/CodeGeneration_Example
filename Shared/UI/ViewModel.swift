import SwiftUI

protocol ViewModel: ObservableObject {
    associatedtype Item: ViewModelItem
    associatedtype DetailItem: ViewModelDetailItem
    
    var items: [Item] { get }
    var detailItem: DetailItem { get }
    
    func makeSearch(query: String, batchSize: Int, startIndex: Int)
    func getDetails(forItem: Item)
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
}

extension ViewModelDetailRow {
    var id: String { return title }
}
