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

class MoviesDetailViewModel: DetailViewModel<MoviesAPI> {}
