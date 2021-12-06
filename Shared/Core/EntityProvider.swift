import Foundation
import DI
import RealmSwift
import BooksApi
import SearchUI

class EntityProvider {
    private(set) var lastQuery = "" {
        didSet {
            if lastQuery != oldValue {
                lastBatchIndex = 0
                hasNext = true
            }
        }
    }
    
    @Injected private var api: BooksAPI!
    private let realm = try! Realm()
    private let batchSize = 20
    private var lastBatchIndex = 0
    private var hasNext = true
    
    func getBooks(forQuery query: String, completion: @escaping ([Book])-> Void) {
        guard query != lastQuery else { return }
        lastQuery = query
        let cached = getCachedBooks(forQuery: query)
        if !cached.isEmpty {
            lastBatchIndex = cached.count / batchSize
            completion(cached)
            return
        }
        
        loadBooks(forQuery: query, completion: { [weak self] books in
            self?.storeBooks(books)
            completion(books)
        })
    }
    
    func getCachedBooks(forQuery query: String) -> [Book] {
        return Array(realm.objects(Book.self).filter{ $0.title.contains(query) })
    }
    
    private func storeBooks(_ books: [Book]) {
        print("\(Self.self).\(#function) ADDING: \(books.map{ $0.title })")
        realm.beginWrite()
        realm.add(books)
        try? realm.commitWrite()
        print("\(Self.self).\(#function) STORED: \(realm.objects(Book.self).map{ $0.title }))")
    }
    
    func getNextIfNeeded(completion: @escaping ([Book]) -> Void) {
        loadBooks(forQuery: lastQuery, completion: completion)
    }
    
    private func loadBooks(forQuery query: String, completion: @escaping ([Book]) -> Void) {
        guard hasNext == true else { return }
        api.perform(query: query, batchSize: batchSize, startIndex: lastBatchIndex) { [weak self] volumes, error in
            let books = volumes.map{ Book(withVolume: $0) }
            if books.isEmpty {
                self?.hasNext = false
            }
            completion(books)
            self?.lastBatchIndex += 1
        }
    }
}

class Book: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var id: String = ""
    var authors: List<String> = List()
    @objc dynamic var language: String?
    @objc dynamic var bookDescription: String?
    @objc dynamic var publishedDate: String?
}



extension Book {
    convenience init(withVolume volume: BooksVolume) {
        self.init()
        self.id = volume.id
        self.title = volume.volumeInfo.title
        self.authors.append(objectsIn: volume.volumeInfo.authors ?? [])
        self.language = volume.volumeInfo.language
        self.bookDescription = volume.volumeInfo.description
        self.publishedDate = volume.volumeInfo.publishedDate
    }
}

extension Book: IViewModelItem {}
