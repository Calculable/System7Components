import SwiftUI

struct System7ButtonStyle: ButtonStyle {

    @Environment(\.scaleFactor) var scaleFactor

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .system7FontLarge()
            .foregroundStyle(configuration.isPressed ? Color(.background) : Color(.foreground))
            .system7ScalablePadding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: 5.0 * scaleFactor)
                        .stroke(lineWidth: 1.0 * scaleFactor)
                        .foregroundStyle(Color(.foreground))
                    RoundedRectangle(cornerRadius: 5.0 * scaleFactor)
                        .fill()
                        .foregroundStyle(configuration.isPressed ? Color(.foreground) : Color(.background))
                }
            }
    }
}

#Preview {
    Button("Date Formats...") {
        print("Pressed")
    }
    .buttonStyle(System7ButtonStyle())
    .system7ScalablePadding()
    .environment(\.scaleFactor, 2)

}
