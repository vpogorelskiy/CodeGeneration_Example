import SearchUI
import MoviesApi

class MoviesViewModel: ViewModel<MoviesAPI> {
    override func reduceItems(_ apiItems: [ApiItem]) -> [ViewModelItem] {
        guard let bookItems = apiItems as? [MovieShort] else {
            return []
        }
        return bookItems.map{ ViewModelItem(id: $0.id,
                                            title: $0.title.safeString,
                                            apiItem: $0) }
    }
    
    override func detailViewModel(for item: IViewModelItem) -> IDetailViewModel {
        return MoviesDetailViewModel(item: item as! ViewModelItem)
    }
}

class MoviesDetailViewModel: DetailViewModel<MoviesAPI> {
    override func reduceItem(_ detailApiItem: ApiDetailItem) -> [IDetailViewModelItem] {
        guard let item = detailApiItem as? MovieFull else {
            return []
        }
        
        let content: [DetailViewModelItem] = [.init(title: "Title", value: item.title),
                                              .init(title: "Year", value: item.released.safeString),
                                              .init(title: "Actors", value: item.actors.safeString),
                                              .init(title: "Launguage", value: item.language.safeString),
                                              .init(title: "Description", value: item.plot.safeString)
        ]
        
        return content
    }   
}
