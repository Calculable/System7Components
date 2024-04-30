import SwiftUI

struct ButtonSizeKey: PreferenceKey {
    static var defaultValue: CGSize? = nil
    
    static func reduce(value: inout CGSize?, nextValue: () -> CGSize?) {
        if let newValue = nextValue() {
            value = newValue
        }
    }
}

struct ButtonSizeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(GeometryReader { geometry in
                Color.clear.preference(key: ButtonSizeKey.self, value: geometry.size)
            })
    }
}

struct System7ImageButtonStyle: ButtonStyle {

    let defaultImage: ImageResource
    let pressedImage: ImageResource

    let width: CGFloat
    let height: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        System7ScaleableImage(resource: configuration.isPressed ? pressedImage : defaultImage, width: width, height: height)
    }
}

struct System7ScaleableImage: View {

    let resource: ImageResource
    let width: CGFloat
    let height: CGFloat
    let resizingMode: Image.ResizingMode

    init(resource: ImageResource, width: CGFloat, height: CGFloat, resizingMode: Image.ResizingMode = .stretch) {
        self.resource = resource
        self.width = width
        self.height = height
        self.resizingMode = resizingMode
    }

    var body: some View {

        switch resizingMode {
            case .tile:
                Image(resource)
                    .interpolation(.none)
                    .resizable(resizingMode: resizingMode)
            case .stretch:
                Image(resource)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .system7ScalableFrame(width: width, height: height)
        }

    }
}

extension View {
    func blink(setBlinkStateOn: () -> (), setBlinkStateOff: () -> ()) async {
        for _ in 0...2 {
            setBlinkStateOn()
            try? await Task.sleep(for: .milliseconds(50))
            setBlinkStateOff()
            try? await Task.sleep(for: .milliseconds(50))
        }
    }
}
