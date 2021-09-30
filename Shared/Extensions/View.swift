import SwiftUI
import CoreGraphics

extension View {
    func favoriteAnimation(from: CGPoint, to: CGPoint, progress: Double) -> some View {
        self.modifier(FavoriteAnimation(from: from, to: to, progress: progress))
    }
}

private struct FavoriteAnimation: AnimatableModifier {

    var animatableData: Double
    let from: CGPoint
    let to: CGPoint

    init(from: CGPoint, to: CGPoint, progress: Double) {
        animatableData = progress
        self.from = from
        self.to = to
    }

    func body(content: Content) -> some View {
        content.position(intermediatePosition)
    }

    // This is a very basic implementation of a color interpolation between two values.
    private var intermediatePosition: CGPoint {
        let rev = 1 - animatableData
        return CGPoint(x: from.x * rev + to.x, y: from.y * rev + to.y)
    }

}
