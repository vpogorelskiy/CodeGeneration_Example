import Foundation
import DI
import SearchUI

class BooksViewModel: IViewModel {
    var isOffline = false
    
    @Published var items: [IViewModelItem] = []
    var itemsPublisher: Published<[IViewModelItem]>.Publisher { $items }
    
    @Published var isLoading = false
    var isLoadingPublisher: Published<Bool>.Publisher { $isLoading }
    
    private var entityProvider = EntityProvider()
    
    func makeSearch(query: String) {
        if isOffline {
            self.items = entityProvider.getCachedBooks(forQuery: query)
        }
        
        entityProvider.getBooks(forQuery: query) { [weak self] books in
            self?.items = books
        }
    }
    
    func loadNextIfNeeded(for item: IViewModelItem) {
        guard isLoading == false,
              isOffline == false,
              items.last?.id == item.id else { return }
        
        isLoading = true
        entityProvider.getNextIfNeeded { [weak self] books in
            self?.items.append(contentsOf: books)
            self?.isLoading = false
        }
    }
    
    func detailViewModel(for item: IViewModelItem) -> IDetailViewModel? {
        guard let book = item as? Book else { return nil }
        return BooksDetailViewModel(book: book)
    }
}

class BooksDetailViewModel: IDetailViewModel {
    @Published var content: [IDetailViewModelItem] = []
    var contentPublisher: Published<[IDetailViewModelItem]>.Publisher { $content }
    
    private let book: Book
    
    public init(book: Book) {
        self.book = book
        self.content = [DetailViewModelItem(title: "Title", value: book.title),
                        DetailViewModelItem(title: "Authors", value: (Array(book.authors)).joined(separator: ", ")),
                        DetailViewModelItem(title: "Published on", value: book.publishedDate ?? ""),
                        DetailViewModelItem(title: "Launguage", value: book.language ?? ""),
                        DetailViewModelItem(title: "Description", value: book.bookDescription ?? ""),
        ]
    }
    
    func getDetails() {}
}
