import Foundation

public protocol IDetailViewModel: AnyObject {
//    var content: [String: String] { get }
    var contentPublisher: Published<[String: String]>.Publisher { get }
    func getDetails()
}
