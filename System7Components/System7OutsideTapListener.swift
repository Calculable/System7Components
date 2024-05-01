import SwiftUI

public struct System7OutsideTapListener<Content: View>: View {
    private let isActive: Bool
    private let dimmColor: Color

    @ViewBuilder private let content: () -> Content
    private let onOutsideTap: () -> ()

    public init(isActive: Bool, dimmColor: Color, content: @escaping () -> Content, onOutsideTap: @escaping () -> Void) {
        self.isActive = isActive
        self.dimmColor = dimmColor
        self.content = content
        self.onOutsideTap = onOutsideTap
    }

    public var body: some View {
        ZStack {
            if isActive {
                dimmColor
                    .system7ScalableFrame(width: 10000, height: 10000) //TODO: Find better solution
                    .contentShape(Rectangle()) // Makes the entire area tappable, not just the visible parts
                    .position(x: 0, y: 0)
                    .onTapGesture {
                        onOutsideTap()
                    }
                    .system7ScalableFrame(width: 0, height: 0)
            }
            content()
        }
        .zIndex(isActive ? 1 : 0)
    }
}
