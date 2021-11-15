import Foundation

public protocol IDetailViewModel: AnyObject {
    var contentPublisher: Published<[IDetailViewModelItem]>.Publisher { get }
    func getDetails()
}

public protocol IDetailViewModelItem {
    var title: String { get }
    var value: String { get }
    var id: String { get }
}

extension IDetailViewModelItem {
    var id: String { title }
}
