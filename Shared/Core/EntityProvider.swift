import Foundation
import DI
import RealmSwift
import BooksApi

class EntityProvider {
    @Injected private var api: BooksAPI!
    private let realm = try! Realm()
    
    private let batchSize = 20
    private var lastQuery = ""
    private var lastBatchIndex = 0
    private var hasNext = true
    
    func getBooks(forQuery query: String, completion: @escaping ([Book])-> Void) {
        let cached = getCachedBooks(forQuery: query)
        if !cached.isEmpty {
            completion(cached)
            return
        }
        
        loadBooks(forQuery: query, completion: completion)
    }
    
    func getCachedBooks(forQuery query: String) -> [Book] {
        return Array(realm.objects(Book.self).filter("title CONTAINS \(query)"))
    }
    
    private func storeBooks(_ books: [Book]) {
        realm.add(books)
    }
    
    private func loadBooks(forQuery query: String, completion: @escaping ([Book]) -> Void) {
        lastBatchIndex += 1
        api.perform(query: query, batchSize: batchSize, startIndex: 0) { volumes, error in
            
        }
    }
}

class Book: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var id: String = ""
    @objc dynamic var authors: [String] = []
    @objc dynamic var language: String?
    @objc dynamic var bookDescription: String?
    @objc dynamic var publishedDate: String?
}

extension Book {
    convenience init(withVolume volume: BooksVolume) {
        self.init()
        self.id = volume.id
        self.title = volume.volumeInfo.title
        self.authors = volume.volumeInfo.authors ?? []
        self.language = volume.volumeInfo.language
        self.bookDescription = volume.volumeInfo.description
        self.publishedDate = volume.volumeInfo.publishedDate
    }
    
    
}
