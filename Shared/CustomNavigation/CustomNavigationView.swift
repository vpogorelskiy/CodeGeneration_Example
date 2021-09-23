import SwiftUI

enum CustomNavigation {
    struct NavigationView<Content>: View where Content: View {
        @ObservedObject private var viewModel: ViewModel
        private let rootView: Content
        
        private let defaultTitle = ""
        
        public init(@ViewBuilder rootContent: @escaping () -> Content) {
            self.viewModel = ViewModel()
            self.rootView = rootContent()
            _ = self.rootView.environmentObject(self.viewModel)
        }
        
        var navigationBar: some View {
            HStack {
                let top: View = viewModel.topView ?? rootView
                let wrapped = top as? TitledView
                
                Text(wrapped?.title ?? defaultTitle)
            }
        }
        
        var body: some View {
            if let last = viewModel.topView {
                last
            } else {
                rootView
            }
        }
    }
}

extension CustomNavigation {
    final class ViewModel: ObservableObject {
        @Published private var stack: [TitledView] = []
        var topView: TitledView? { return stack.last }
        
        func push<V: View>(_ next: V) {
            _ = next.environmentObject(self)
            stack.append((next as? TitledView) ?? TitledView(title: "", wrappedView: AnyView(next)))
        }
        
        func pop() {
            _ = stack.popLast()
        }
        
        func popToRoot() {
            stack = []
        }
    }
}

struct CustomNavigation_Previews: PreviewProvider {
    static var previews: some View {
        Text("No content")
    }
}
