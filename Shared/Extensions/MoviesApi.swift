import MoviesApi
import SearchUI

//extension MoviesAPI: AbstractApi {
//    typealias Item = MovieShort
//    typealias DetailItem = MovieFull
//}
//
//extension MovieShort: ViewModelItem {}
//
//extension MovieFull: ViewModelDetailItem {
//    var content: [ViewModelDetailRow] {
//        return [.init(title: "Title", value: title),
//                .init(title: "Year", value: released.safeString),
//                .init(title: "Actors", value: actors.safeString),
//                .init(title: "Launguage", value: language.safeString),
//                .init(title: "Description", value: plot.safeString)
//        ]
//    }
//
//    public var id: String {
//        return "\(hashValue)"
//    }
//}
