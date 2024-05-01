import Foundation
import SwiftUI

/// A window frame with a header, border and optional scrollbars
public struct System7Frame<Content: View>: View {

    private let title: String
    private let isFocused: Bool
    private let scrollbarBehavior: System7FrameScrollbarBehavior
    private let onClose: (() -> ())?
    @ViewBuilder public let content: () -> Content

    public init(title: String, isFocused: Bool, scrollbarBehavior: System7FrameScrollbarBehavior = .enabled, onClose: (() -> ())? = nil, content: @escaping () -> Content) {
        self.title = title
        self.isFocused = isFocused
        self.scrollbarBehavior = scrollbarBehavior
        self.onClose = onClose
        self.content = content
    }

    public var body: some View {

        VStack(alignment: .leading, spacing: 0) {
            System7FrameHeader(title: title, isFocused: isFocused, onClose: onClose)
            
            if scrollbarBehavior == .none {
                content()
            } else {
                System7ScrollView(isFocused: isFocused, isEnabled: scrollbarBehavior == .enabled) {
                    content()
                }
            }
        }
        .system73DBorder()
    }
}

public enum System7FrameScrollbarBehavior {
    /// dont show a scrollbar. Use this if you provide your own ScrollView in the frame
    case none
    
    /// show a fake scrollbar (doesn't have any functionality)
    case enabled
    
    /// show a disabled scrollbar
    case disabled
}

private struct System7FrameHeader: View {

    @Environment(\.scaleFactor) var scaleFactor


    let title: String
    let isFocused: Bool
    let onClose: (() -> ())?

    init(title: String, isFocused: Bool, onClose: (() -> Void)? = nil) {
        self.title = title
        self.isFocused = isFocused
        self.onClose = onClose
    }

    var body: some View {
        
        Group {
            if isFocused {
                ZStack {
                    HStack(spacing: 1 * scaleFactor) {
                        System7WindowGrip()
                            .system7ScalableFrame(width: 5)
                        System7CloseButton(onClose: onClose)
                        System7WindowGrip()
                        System7FrameHeaderTitle(title: title, isFocused: isFocused)
                            .system7ScalablePadding(.horizontal, 5)
                            .system7ScalablePadding(.vertical, 2)
                            .layoutPriority(1)
                        System7WindowGrip()
                        System7MaximiseButton()
                        System7WindowGrip()
                            .system7ScalableFrame(width: 5)
                    }
                    .background {
                        Color(.gray100)
                    }
                }
                .system7ScalablePadding(1 * scaleFactor)
                .background {
                    Color(.lavender100)
                }
            } else {
                System7FrameHeaderTitle(title: title, isFocused: isFocused)
                    .system7ScalableFrame(minHeight: 20)
                    .background {
                        Color(.background)
                    }
                    .system7ScalableFrame(maxWidth: .infinity)
            }
        }
        .system7ScalablePadding(1)
        .system7PlainBorder(color: .foreground)


    }
}

private struct System7FrameHeaderTitle: View {

    let title: String
    let isFocused: Bool
    
    var body: some View {
        Text(title)
            .system7FontLarge()
            .foregroundStyle(isFocused ? Color(.foreground) : Color(.gray300))
        
    }
}

private struct System7WindowGrip: View {

    @Environment(\.scaleFactor) var scaleFactor

    var body: some View {
        VStack(spacing: 1*scaleFactor) {

            ForEach(0..<6) { _ in
                Rectangle()
                    .foregroundStyle(Color(.gray400))
                    .system7ScalableFrame(height: 1)
            }
        }
    }
}

private struct System7CloseButton: View {

    struct System7CloseButtonStyle: ButtonStyle {


        func makeBody(configuration: Configuration) -> some View {
            System7ImageButtonStyle(defaultImage: .Frame.closeButton, pressedImage: .Frame.buttonPressed, width: 16, height: 16).makeBody(configuration: configuration)
        }
    }

    let onClose: (() -> ())?

    init(onClose: (() -> Void)? = nil) {
        self.onClose = onClose
    }

    var body: some View {
        Button("Close") {
            onClose?()
        }
        .buttonStyle(System7CloseButtonStyle())
    }
}

private struct System7MaximiseButton: View {

    struct System7MaximiseButtonStyle: ButtonStyle {


        func makeBody(configuration: Configuration) -> some View {
            System7ImageButtonStyle(defaultImage: .Frame.maximiseButton, pressedImage: .Frame.buttonPressed, width: 16, height: 16).makeBody(configuration: configuration)
        }
    }
    
    var body: some View {
        Button("Maximise") {
            print("Maximise pressed")
        }
        .buttonStyle(System7MaximiseButtonStyle())
    }
}

#Preview("Long Text"){
    System7Frame(title: "a long text", isFocused: true) {
        Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.")
    }
    .system7ScalableFrame(height: 200)
    .system7ScalablePadding()
    .environment(\.scaleFactor, 2)

}

#Preview("Short Text") {
    System7Frame(title: "a short text", isFocused: true) {
        Text("1\n2\n3\n4")
    }
    .system7ScalablePadding()
    .environment(\.scaleFactor, 2)

}

#Preview("Header") {
    System7FrameHeader(title: "Example Header", isFocused: false)
        .system7ScalablePadding()
        .environment(\.scaleFactor, 2)

}
