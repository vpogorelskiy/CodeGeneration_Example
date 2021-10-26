import Foundation

public protocol IDetailViewModel: AnyObject {
    var content: [String: String] { get }
    func getDetails()
}
