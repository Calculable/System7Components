import SwiftUI

public struct System7ProgressViewStyle: ProgressViewStyle {

    @Environment(\.scaleFactor) private var scaleFactor

    public init() {
    }

    public func makeBody(configuration: Configuration) -> some View {
        
        let fractionCompleted = configuration.fractionCompleted ?? 0
        
        return GeometryReader { geo in
            HStack(spacing: 0) {
                Color(.gray500)
                    .system7ScalableFrame(width: geo.size.width/scaleFactor * fractionCompleted)
                Color(.lavender100)
                    .system7ScalableFrame(width: geo.size.width/scaleFactor * (1.0 - fractionCompleted))
            }
        }
        .system7ScalableFrame(height: 9)
        .system7PlainBorder(color: .foreground)
        .system7ScalableFrame(idealWidth: 159)
    }
}

#Preview {
    struct System7ProgressViewExample: View {
        
        @State private var progress = 0.6
        
        var body: some View {
            ProgressView(value: progress)
                .progressViewStyle(System7ProgressViewStyle())
        }
    }
    
    return System7ProgressViewExample()
        .system7ScalablePadding()
        .environment(\.scaleFactor, 2)

}
