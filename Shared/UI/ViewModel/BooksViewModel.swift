import SearchUI
import BooksApi

class BooksViewModel: ViewModel<BooksAPI> {
    override func reduceItems(_ apiItems: [IApiItem]) -> [ViewModelItem] {
        guard let bookItems = apiItems as? [BooksVolume] else {
            return []
        }
        return bookItems.map{ ViewModelItem(id: $0.id,
                                            title: $0.title.safeString,
                                            apiItem: $0) }
    }
    
    override func detailViewModel(for item: IViewModelItem) -> IDetailViewModel {
        return BooksDetailViewModel(item: item as! ViewModelItem)
    }
}

class BooksDetailViewModel: DetailViewModel<BooksAPI> {
    override func reduceItem(_ detailApiItem: IDetailApiItem) -> [IDetailViewModelItem] {
        guard let item = detailApiItem as? VolumeInfo else {
            return []
        }
        
        let content: [DetailViewModelItem] = [.init(title: "Title", value: item.title),
                                              .init(title: "Authors", value: (item.authors ?? []).joined(separator: ", ")),
                                              .init(title: "Published on", value: item.publishedDate ?? ""),
                                              .init(title: "Launguage", value: item.language ?? ""),
                                              .init(title: "Description", value: item.description ?? "")
        ]
        
        return content
    }
    
}
