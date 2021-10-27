
import Foundation

public @propertyWrapper struct Injected<Value> {
    private var storedValue: Value!
    
    var wrappedValue: Value! {
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
    
    var projectedValue: Injected<Value> {
        get { self }
        mutating set { self = newValue }
    }
}
