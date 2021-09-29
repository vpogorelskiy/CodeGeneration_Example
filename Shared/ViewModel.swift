import SwiftUI

protocol ViewModel: ObservableObject {
    var items: [String] { get }
    
    func makeSearch(query: String, batchSize: Int, startIndex: Int)
    
}

protocol DetailItem {
    var content: [(String, String)] { get }
    
    
    
    
}
