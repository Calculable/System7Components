import Foundation
import SwiftUI

public struct System7Divider: View {

    @Environment(\.scaleFactor) private var scaleFactor

    public init() {
    }

    public var body: some View {
        Line()
            .stroke(style: StrokeStyle(lineWidth: 1*scaleFactor, dash: [1*scaleFactor]))
            .system7ScalableFrame(height: 1)
    }
}

private struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

#Preview {
    System7Divider()
        .system7ScalablePadding()
        .environment(\.scaleFactor, 2)

}
