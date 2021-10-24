import SwiftUI
import Foundation

public extension CustomNavigation {
    struct TitledView: View {
        let title: String
        let wrappedView: AnyView
        
        public var body: some View {
            wrappedView
        }
    }
}

public extension CustomNavigation {
    struct Link<Label: View, Destination: View>: View  {
        @EnvironmentObject private var viewModel: ViewModel
        
        private let destination: Destination
        private let label: Label
        
        public init(@ViewBuilder destination: () -> Destination, @ViewBuilder label: () -> Label) {
            self.destination = destination()
            self.label = label()
        }
        
        public var body: some View {
            label.onTapGesture {
                viewModel.push(destination)
            }.foregroundColor(.blue)
        }
    }
}
