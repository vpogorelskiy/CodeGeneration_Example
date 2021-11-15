import SwiftUI

extension CustomNavigation {
    public struct NavigationLazyView<Content>: View where Content: View {
        let build: () -> Content
    
        public init(@ViewBuilder build: @escaping () -> Content) {
            self.build = build
        }
        
        public var body: some View {
            build()
        }
    }
}
