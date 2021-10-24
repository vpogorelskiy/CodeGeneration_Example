class Resolver {
    
    static let sharedInstance: Resolver = .init()
    
    typealias ResolveBlock<T> = (Resolver) -> T
    
    private var resolveBlocks: [String: ResolveBlock<Any>] = [:]
    
    func register<T>(_ type: T.Type, resolveBlock: @escaping ResolveBlock<T>) {
        let typeName = stringFrom(type: type.self)
        resolveBlocks[typeName] = resolveBlock
    }
    
    func resolve<T>(_ type: T.Type) -> T? {
        let typeName = stringFrom(type: type.self)
        let block = resolveBlocks[typeName]
        
        return block?(self) as? T
    }
    
    private func stringFrom<T>(type: T.Type) -> String {
        return type == Any.self ? "Any" : String(describing: type.self)
    }
}
