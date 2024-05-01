import SwiftUI

public struct System73DButtonStyle: ButtonStyle {

    private let isSymbolButton: Bool

    public init(isSymbolButton: Bool) {
        self.isSymbolButton = isSymbolButton
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .system7FontLarge()
            .system7ScalablePadding(isSymbolButton ? EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2) : EdgeInsets(top: 2, leading: 8, bottom: 2, trailing: 8))
            .background(Color(configuration.isPressed ? .gray300 : .gray100))
            .system7ScalablePadding(1)
            .system7Border(width: 1, edges: [.bottom, .trailing], color: Color(configuration.isPressed ? .gray100 : .gray300))
            .system7Border(width: 1, edges: [.leading, .top], color: Color(configuration.isPressed ? .gray500: .background))
            .system7ScalablePadding(1)
            .system7Border(width: 1, edges: [.bottom, .trailing], color: Color(configuration.isPressed ? .gray500: .gray300))
            .system7Border(width: 1, edges: [.leading, .top], color: Color(configuration.isPressed ? .foreground : .gray100))
            .system7ScalablePadding(1)
            .system7Border(width: 1, edges: [.bottom, .trailing], color: Color(.foreground).opacity(configuration.isPressed ? 0 : 1))
            .system7Border(width: 1, edges: [.leading, .top], color: Color(.gray500).opacity(configuration.isPressed ? 0 : 1))
    }
}

#Preview("Text-Button") {
    Button("Button with Text") {
        print("Button Pressed")
    }
    .buttonStyle(System73DButtonStyle(isSymbolButton: false))
    .system7ScalablePadding()
    .environment(\.scaleFactor, 2)

}

#Preview("Symbol-Button") {
    Button {
        print("Button Pressed")
    } label: {
        Label("Demo", systemImage: "star.fill")
            .labelStyle(.iconOnly)
    }
    .buttonStyle(System73DButtonStyle(isSymbolButton: true))
    .system7ScalablePadding()
    .environment(\.scaleFactor, 2)

}
