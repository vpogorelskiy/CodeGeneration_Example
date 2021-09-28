import SwiftUI
import Foundation

extension CustomNavigation {
    struct TitledView: View {
        let title: String
        let wrappedView: AnyView
        
        var body: some View {
            wrappedView
        }
    }
}

extension CustomNavigation {
    struct Link<Label: View, Destination: View>: View  {
        @EnvironmentObject private var viewModel: ViewModel
        
        private let label: Label
        private let destination: Destination
        
        public init(destination: Destination, @ViewBuilder label: @escaping () -> Label) {
            self.destination = destination
            self.label = label()
        }
        
        public var body: some View {
            label.onTapGesture {
                viewModel.push(destination)
            }.foregroundColor(.blue)
        }
    }
}
