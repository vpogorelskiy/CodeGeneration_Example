import SwiftUI

public extension View {
    func customNavigationTitle(_ title: String) -> CustomNavigation.TitledView {
        return CustomNavigation.TitledView(title: title,
                                           wrappedView: AnyView(self))
    }
}
