import SwiftUI

/// A view that wrapps it's content into (non-functional) scrollbars
struct System7ScrollView<Content: View>: View {
    var isFocused: Bool
    var isEnabled: Bool
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            VStack(spacing: 0) {
                content()
                Spacer()
                System7HorizontalScrollbar(isFocused: isFocused, isEnabled: isEnabled)
            }
            System7VerticalScrollbar(isFocused: isFocused, isEnabled: isEnabled)
        }
    }
}

private struct System7VerticalScrollbar: View {

    let isFocused: Bool
    let isEnabled: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            if isFocused {
                System7ScrollButton(variant: .up, isEnabled: isEnabled)
            }
            ScrollbarSlider(isVertical: true, isEnabled: isEnabled, isFocused: isFocused)
            
            if isFocused {
                System7ScrollButton(variant: .down, isEnabled: isEnabled)
            }
            
            if isFocused {
                System7ScaleableImage(resource: .Scrollbar.windowResizeKnob, width: 15, height: 15)
            } else {
                Color(.background)
                    .system7ScalableFrame(width: 15, height: 15)
                    .system7Border(width: 1, edges: [.top], color: Color(.foreground))
            }
        }
        .system7Border(width: 1, edges: [.leading], color: Color(.foreground))
        .system7ScalableFrame(width: 15)

    }
}

private struct System7HorizontalScrollbar: View {

    let isFocused: Bool
    let isEnabled: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            if isFocused {
                System7ScrollButton(variant: .left, isEnabled: isEnabled)
            }
            
            ScrollbarSlider(isVertical: false, isEnabled: isEnabled, isFocused: isFocused)
            
            if isFocused {
                System7ScrollButton(variant: .right, isEnabled: isEnabled)
            }
        }
        .system7Border(width: 1, edges: [.top], color: Color(.foreground))
        .system7ScalableFrame(height: 15)
    }
}

private struct ScrollbarSlider: View {
    
    @Environment(\.scaleFactor) var scaleFactor

    let isVertical: Bool
    let isEnabled: Bool
    let isFocused: Bool
    
    @State private var previousOffset = 0.0
    @State private var offset = 0.0
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: isVertical ? .top : .leading) {
                if isFocused {
                    if isEnabled {

                        System7ScaleableImage(resource: .Scrollbar.scrollbarBackgroundPattern, width: 4, height: 4, resizingMode: .tile)


                        System7ScaleableImage(resource: isVertical ? .Scrollbar.scrollKnobVertical : .Scrollbar.scrollKnobHorizontal, width: 15, height: 15)
                            .offset(x: isVertical ? 0 : offset, y: isVertical ? offset : 0)
                            .gesture(
                                DragGesture(minimumDistance: 0)
                                    .onChanged { gesture in
                                        offset = min(max(0, previousOffset + (isVertical ? gesture.translation.height : gesture.translation.width)), (isVertical ? geo.size.height : geo.size.width) - 15*scaleFactor)
                                    }
                                    .onEnded { _ in
                                        previousOffset = offset
                                    }
                            )
                    } else {
                        Color(.gray100)
                    }
                    
                } else {
                    Color(.background)
                }
            }
        }
    }
}

private struct System7ScrollButton: View {
    
    @Environment(\.scaleFactor) var scaleFactor

    let variant: System7ScrollButtonStyle.System7ScrollButtonVariant
    let isEnabled: Bool
    
    var accessibilityString: String {
        switch variant {
            case .up:
                "scroll up"
            case .down:
                "scroll down"
            case .left:
                "scroll left"
            case .right:
                "scroll right"
        }
    }
    
    var body: some View {
        
        Button(accessibilityString) {
            if isEnabled {
                print("Scrollbutton pressed")
            }
        }
        .buttonStyle(System7ScrollButtonStyle(variant: variant, isEnabled: isEnabled, scaleFactor: scaleFactor))
    }
}

private struct System7ScrollButtonStyle: ButtonStyle {
    enum System7ScrollButtonVariant {
        case up
        case down
        case left
        case right
    }
    
    let variant: System7ScrollButtonVariant
    let isEnabled: Bool
    let scaleFactor: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        if isEnabled {
            switch variant {
                case .up:
                    System7ImageButtonStyle(defaultImage: .Scrollbar.scrollButtonUp, pressedImage: .Scrollbar.scrollButtonUpPressed, width: 14, height: 15).makeBody(configuration: configuration)
                case .down:
                    System7ImageButtonStyle(defaultImage: .Scrollbar.scrollButtonDown, pressedImage: .Scrollbar.scrollButtonDownPressed, width: 15, height: 15).makeBody(configuration: configuration)
                case .left:
                    System7ImageButtonStyle(defaultImage: .Scrollbar.scrollButtonLeft, pressedImage: .Scrollbar.scrollButtonLeftPressed, width: 15, height: 15).makeBody(configuration: configuration)
                case .right:
                    System7ImageButtonStyle(defaultImage: .Scrollbar.scrollButtonRight, pressedImage: .Scrollbar.scrollButtonRightPressed, width: 15, height: 15).makeBody(configuration: configuration)
            }
        } else {
            switch variant {
                case .up:
                    System7ImageButtonStyle(defaultImage: .Scrollbar.scrollButtonUpDisabled, pressedImage: .Scrollbar.scrollButtonUpDisabled, width: 15, height: 15).makeBody(configuration: configuration)
                case .down:
                    System7ImageButtonStyle(defaultImage: .Scrollbar.scrollButtonDownDisabled, pressedImage: .Scrollbar.scrollButtonDownDisabled, width: 15, height: 15).makeBody(configuration: configuration)
                case .left:
                    System7ImageButtonStyle(defaultImage: .Scrollbar.scrollButtonLeftDisabled, pressedImage: .Scrollbar.scrollButtonLeftDisabled, width: 15, height: 15).makeBody(configuration: configuration)
                case .right:
                    System7ImageButtonStyle(defaultImage: .Scrollbar.scrollButtonRightDisabled, pressedImage: .Scrollbar.scrollButtonRightDisabled, width: 15, height: 15).makeBody(configuration: configuration)
            }
        }
    }
}

#Preview {
    System7ScrollView(isFocused: true, isEnabled: true) {
        Text("Example")
            .system7FontDisplay()

    }
    .environment(\.scaleFactor, 2)
    .system7ScalablePadding()

}
