import Combine
public protocol IViewModel {
//    var isLoading: Bool { get }
//    var items: [IViewModelItem] { get }
    var itemsPublisher: Published<[IViewModelItem]>.Publisher { get }
    var isLoadingPublisher: Published<Bool>.Publisher { get }
    func makeSearch(query: String)
    func loadNextIfNeeded(for: IViewModelItem)
    func detailViewModel(for: IViewModelItem) -> IDetailViewModel?
}

public protocol IViewModelItem {
    var title: String { get }
    var id: String { get }
}
