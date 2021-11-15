import Foundation

@propertyWrapper public struct Injected<Value> {
    private var storedValue: Value!
    
    public init() {}
    
    public var wrappedValue: Value! {
        mutating set {
            storedValue = newValue
        }
        mutating get {
            guard storedValue == nil else {
                return storedValue
            }
            storedValue = ServiceLocator.sharedInstance.getInstanceOf(type: Value.self)
            return storedValue
        }
    }
    
    public var projectedValue: Injected<Value> {
        get { self }
        mutating set { self = newValue }
    }
}
