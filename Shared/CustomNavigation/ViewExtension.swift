import SwiftUI

extension View {
    public func customNavigationTitle(_ title: String) -> some View {
        return CustomNavigation.TitledView(title: title,
                                           wrappedView: AnyView(self))
    }
}
