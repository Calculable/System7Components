import SwiftUI

public struct System7TextfieldStyle: TextFieldStyle {

    public init() {}

    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .shadow(radius: 0)
            .system7FontLarge()
            .system7ScalablePadding(4)
            .background(Color(.background))
            .system7PlainBorder(color: .foreground)
    }
}

#if os(macOS)
extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get { .none }
        set { }
    }
}
#endif

#Preview {
    struct System7TextfieldExample: View {
        
        @State var text: String = "Hello World"

        var body: some View {
            
            TextField("My Textfield", text: $text)
                .textFieldStyle(System7TextfieldStyle())
        }
    }
    
    return System7TextfieldExample()
        .loadCustomFonts()
        .system7ScalablePadding()
        .environment(\.scaleFactor, 2)


}
