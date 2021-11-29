import Foundation
import DI
import RealmSwift
import BooksApi

class EntityProvider {
    @Injected var api: BooksAPI!
    let realm = try! Realm()
    
    
}
