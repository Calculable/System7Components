import SwiftUI

struct System7PrimaryButtonStyle: ButtonStyle {

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
            .system7ScalablePadding(3)
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: 7.0 * scaleFactor)
                        .stroke(lineWidth: 3.0 * scaleFactor)
                        .foregroundStyle(Color(.foreground))
                }
            }
    }
}

#Preview {
    Button("OK") {
        print("Pressed")
    }
    .buttonStyle(System7PrimaryButtonStyle())
    .system7ScalablePadding()
    .environment(\.scaleFactor, 2)

}
