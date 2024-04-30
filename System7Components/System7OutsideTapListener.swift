import SwiftUI

struct System7OutsideTapListener<Content: View>: View {
    let isActive: Bool
    let dimmColor: Color
    
    @ViewBuilder let content: () -> Content
    let onOutsideTap: () -> ()
    
    var body: some View {
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
