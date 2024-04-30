import SwiftUI

struct System7ScalableFrameModifier: ViewModifier {

    @Environment(\.scaleFactor) var scaleFactor

    let minWidth: CGFloat?
    let idealWidth: CGFloat?
    let maxWidth: CGFloat?
    let minHeight: CGFloat?
    let idealHeight: CGFloat?
    let maxHeight: CGFloat?
    let alignment: Alignment?

    init(minWidth: CGFloat?, idealWidth: CGFloat?, maxWidth: CGFloat?, minHeight: CGFloat?, idealHeight: CGFloat?, maxHeight: CGFloat?, alignment: Alignment?) {
        self.minWidth = minWidth
        self.idealWidth = idealWidth
        self.maxWidth = maxWidth
        self.minHeight = minHeight
        self.idealHeight = idealHeight
        self.maxHeight = maxHeight
        self.alignment = alignment
    }

    func body(content: Content) -> some View {

        let scaledMinWidth = minWidth.flatMap({$0 * scaleFactor})
        let scaledIdealWidth = idealWidth.flatMap({$0 * scaleFactor})
        let scaledMaxWidth = maxWidth.flatMap({$0 * scaleFactor})
        let scaledMinHeight = minHeight.flatMap({$0 * scaleFactor})
        let scaledIdealHeight = idealHeight.flatMap({$0 * scaleFactor})
        let scaledMaxHeight = maxHeight.flatMap({$0 * scaleFactor})

        content
            .frame(minWidth: scaledMinWidth, idealWidth: scaledIdealWidth, maxWidth: scaledMaxWidth, minHeight: scaledMinHeight, idealHeight: scaledIdealHeight, maxHeight: scaledMaxHeight, alignment: alignment ?? .center)
    }
}

struct System7ScalableAbsoluteFrameModifier: ViewModifier {

    @Environment(\.scaleFactor) var scaleFactor

    let width: CGFloat?
    let height: CGFloat?
    let alignment: Alignment?

    init(width: CGFloat?, height: CGFloat?, alignment: Alignment?) {
        self.width = width
        self.height = height
        self.alignment = alignment
    }

    func body(content: Content) -> some View {

        let scaledWidth = width.flatMap({$0 * scaleFactor})
        let scaledHeight = height.flatMap({$0 * scaleFactor})

        content
            .frame(width: scaledWidth, height: scaledHeight, alignment: alignment ?? .center)
    }
}

struct System7ScalablePaddingEdgeInsetModifier: ViewModifier {

    @Environment(\.scaleFactor) var scaleFactor

    let edgeInsets: EdgeInsets

    func body(content: Content) -> some View {

        let scaledEdgeInset = EdgeInsets(top: edgeInsets.top * scaleFactor, leading: edgeInsets.leading * scaleFactor, bottom: edgeInsets.bottom * scaleFactor, trailing: edgeInsets.trailing * scaleFactor)
        content
            .padding(scaledEdgeInset)
    }
}

struct System7ScalablePaddingModifier: ViewModifier {

    @Environment(\.scaleFactor) var scaleFactor

    let edges: Edge.Set
    let length: CGFloat?

    init(edges: Edge.Set, length: CGFloat?) {
        self.edges = edges
        self.length = length
    }

    func body(content: Content) -> some View {
        content
            .padding(edges, length.flatMap({$0 * scaleFactor}))
    }
}



extension View {
    func system7ScalableFrame(minWidth: CGFloat? = nil, idealWidth: CGFloat? = nil, maxWidth: CGFloat? = nil, minHeight: CGFloat? = nil, idealHeight: CGFloat? = nil, maxHeight: CGFloat? = nil, alignment: Alignment? = nil) -> some View {
        modifier(System7ScalableFrameModifier(minWidth: minWidth, idealWidth: idealWidth, maxWidth: maxWidth, minHeight: minHeight, idealHeight: idealHeight, maxHeight: maxHeight, alignment: alignment))
    }

    func system7ScalableFrame(width: CGFloat? = nil, height: CGFloat? = nil, alignment: Alignment? = nil) -> some View {
        modifier(System7ScalableAbsoluteFrameModifier(width: width, height: height, alignment: alignment))
    }

    func system7ScalablePadding(_ length: CGFloat? = nil) -> some View {
        modifier(System7ScalablePaddingModifier(edges: .all, length: length))
    }

    func system7ScalablePadding(_ edges: Edge.Set = .all, _ length: CGFloat? = nil) -> some View {
        modifier(System7ScalablePaddingModifier(edges: edges, length: length))
    }

    func system7ScalablePadding(_ edgeInsets: EdgeInsets) -> some View {
        modifier(System7ScalablePaddingEdgeInsetModifier(edgeInsets: edgeInsets))
    }
}

