import SwiftUI

public extension CustomNavigation {
    struct NavigationView<Content>: View where Content: View {
        @ObservedObject private var viewModel: ViewModel
        private let rootView: Content
        private let defaultTitle = "No title"
        
        public init(@ViewBuilder rootContent: @escaping () -> Content) {
            self.viewModel = ViewModel()
            self.rootView = rootContent()
            _ = self.rootView.environmentObject(self.viewModel)
        }
        
        var navTitle: String {
            if let topWrapped = viewModel.topView {
                return topWrapped.title ?? ""
            }
            
            if let rootWrapped = rootView as? CustomNavigation.TitledView {
                return rootWrapped.title ?? ""
            }
            
            return defaultTitle
        }
        
        var navigationBar: some View {
            VStack {
                HStack {
                    if viewModel.topView != nil {
                        Button("<") {
                            viewModel.pop()
                        }.padding()
                    }
                    Spacer()
                    Text(navTitle)
                    Spacer()
                }
                Divider().frame(height: 2)
            }
            .frame(height: 44)
        }
        
        public var body: some View {
            VStack {
                navigationBar
                Spacer()
                if let last = viewModel.topView {
                    last.environmentObject(viewModel)
                } else {
                    rootView.environmentObject(viewModel)
                }
                Spacer()
            }
        }
    }
}

extension CustomNavigation {
    final class ViewModel: ObservableObject {
        @Published var stack: [CustomNavigation.TitledView] = []
        var topView: CustomNavigation.TitledView? { return stack.last }
        
        func push<V: View>(_ next: V) {
            if let nextTitled = next as? CustomNavigation.TitledView {
                stack.append(nextTitled)
            } else {
                stack.append(CustomNavigation.TitledView(title: "", wrappedView: AnyView(next)))
            }
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
        CustomNavigation.NavigationView {
            VStack {
                let endDest = Text("THE END")
                    .customNavigationTitle("End Header")
                
                let second = CustomNavigation.Link(destination: { endDest },
                                                   label: { Text("To end") })
                    .customNavigationTitle("2nd header")
                
                CustomNavigation.Link(destination: { second },
                                                   label: { Text("To 2nd") })
                    .customNavigationTitle("First header")
                
            }.customNavigationTitle("Root screen")
        }
    }
}
