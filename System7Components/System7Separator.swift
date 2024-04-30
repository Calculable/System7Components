import Foundation
import SwiftUI

struct System7Divider: View {

    @Environment(\.scaleFactor) var scaleFactor

    var body: some View {
        Line()
            .stroke(style: StrokeStyle(lineWidth: 1*scaleFactor, dash: [1*scaleFactor]))
            .system7ScalableFrame(height: 1)
    }
}

struct Line: Shape {
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
