import SwiftUI

public struct System7TextfieldStyle: TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .shadow(radius: 0)
            .system7PlainBorder(color: Color(.background))
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
        
        @State var test: String = "Hello World"
        
        var body: some View {
            
            TextField("My Textfield", text: $test)
                .textFieldStyle(System7TextfieldStyle())
        }
    }
    
    return System7TextfieldExample()
        .environment(\.scaleFactor, 2)

}
