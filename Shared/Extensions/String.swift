extension Optional where Wrapped == String {
    var safeString: String { return self ?? "" }
}
