import SwiftUI

fileprivate struct BorderModifier: ViewModifier {

    @Environment(\.scaleFactor) private var scaleFactor

    let width: CGFloat
    let edges: [Edge]
    let color: Color

    func body(content: Content) -> some View {
        content
            .overlay(EdgeBorder(width: width*scaleFactor, edges: edges).foregroundColor(color))
    }
}

fileprivate struct System73DBorderModifier: ViewModifier {

    @Environment(\.scaleFactor) private var scaleFactor

    func body(content: Content) -> some View {
        content
            .background {
                Color(.background)
                    .system7Border(width: 1*scaleFactor, edges: [.bottom, .trailing], color: Color(.foreground))
                    .offset(x: 1*scaleFactor, y: 1*scaleFactor)
            }
            .border(Color(.foreground), width: 1*scaleFactor)
    }
}

fileprivate struct System7PNGShapedModifier: ViewModifier {

    @Environment(\.scaleFactor) private var scaleFactor

    let imageResource: ImageResource
    let imageWidth: CGFloat
    let imageHeight: CGFloat
    let width: CGFloat
    let color: Color
    let isActive: Bool

    var image: some View {
        System7ScaleableImage(resource: imageResource, width: imageWidth, height: imageHeight)
    }

    func body(content: Content) -> some View {
        if isActive {
            content
                .mask(image)
                .system7ScalablePadding(width)
                .background(color)
                .mask { // a veryyyyy hacky way to apply a black border around the non transparent parts of the image
                    ZStack {
                        image
                            .offset(x: scaleFactor, y: 0)
                        image
                            .offset(x: -scaleFactor, y: 0)
                        image
                            .offset(x: 0, y: scaleFactor)
                        image
                            .offset(x: 0, y: -scaleFactor)
                    }
                }
        } else {
            content
        }
    }
}

fileprivate struct System7ModalBorderModifier: ViewModifier {

    @Environment(\.scaleFactor) var scaleFactor

    func body(content: Content) -> some View {
        content
            .border(Color(.foreground), width: scaleFactor)
            .system7ScalablePadding(scaleFactor)
            .border(Color(.lavender300), width: scaleFactor)
            .system7ScalablePadding(scaleFactor)
            .border(Color(.gray200), width: scaleFactor)
            .system7ScalablePadding(scaleFactor)
            .border(Color(.lavender100), width: scaleFactor)
            .system7ScalablePadding(scaleFactor)
            .border(Color(.foreground), width: scaleFactor)
    }
}

fileprivate struct System7PlainBorderModifier: ViewModifier {

    @Environment(\.scaleFactor) var scaleFactor
    let color: Color
    let width: CGFloat

    func body(content: Content) -> some View {
        content
            .border(color, width: width * scaleFactor)
    }
}

extension View {

    public func system7Border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        modifier(BorderModifier(width: width, edges: edges, color: color))
    }

    public func system73DBorder() -> some View {
        modifier(System73DBorderModifier())

    }

    public func system7PNGShapedBorder(image: ImageResource, imageWidth: CGFloat, imageHeight: CGFloat, width: CGFloat, color: Color, isActive: Bool) -> some View {
        modifier(System7PNGShapedModifier(imageResource: image, imageWidth: imageWidth, imageHeight: imageHeight, width: width, color: color, isActive: isActive))
    }

    public func system7ModalBorder() -> some View {
        modifier(System7ModalBorderModifier())
    }

    public func system7PlainBorder(width: CGFloat = 1.0) -> some View {
        modifier(System7PlainBorderModifier(color: Color.foreground, width: width))
    }

    public func system7PlainBorder(color: Color, width: CGFloat = 1.0) -> some View {
        modifier(System7PlainBorderModifier(color: color, width: width))
    }
}


fileprivate struct EdgeBorder: Shape {
    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        edges.map { edge -> Path in
            switch edge {
                case .top: return Path(.init(x: rect.minX, y: rect.minY, width: rect.width, height: width))
                case .bottom: return Path(.init(x: rect.minX, y: rect.maxY - width, width: rect.width, height: width))
                case .leading: return Path(.init(x: rect.minX, y: rect.minY, width: width, height: rect.height))
                case .trailing: return Path(.init(x: rect.maxX - width, y: rect.minY, width: width, height: rect.height))
            }
        }.reduce(into: Path()) { $0.addPath($1) }
    }
}


#Preview("Edges-Border") {
    Text("Example")
        .system7FontDisplay()
        .system7Border(width: 3, edges: [.leading, .top], color: Color(.lavender500))
        .system7ScalablePadding()
        .environment(\.scaleFactor, 2)

}

#Preview("3D-Border") {
    Text("Example")
        .system7FontDisplay()
        .system73DBorder()
        .system7ScalablePadding()
        .environment(\.scaleFactor, 2)

}

#Preview("PNG-Shaped Border") {
    Image(.Icons.file)
        .system7FontDisplay()
        .system7PNGShapedBorder(image: .Icons.file, imageWidth: 25, imageHeight: 32, width: 3, color: Color(.lavender500), isActive: true)
        .system7ScalablePadding()
        .environment(\.scaleFactor, 2)

}

#Preview("Modal Border") {
    Text("Example")
        .system7FontDisplay()
        .system7ModalBorder()
        .system7ScalablePadding()
        .environment(\.scaleFactor, 2)

}
