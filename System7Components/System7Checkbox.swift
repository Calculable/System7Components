import SwiftUI

struct System7Checkbox: View {
    
    let title: String
    @Binding var isChecked: Bool
    
    var body: some View {
        Button(title) {
            isChecked.toggle()
        }
        .buttonStyle(System7CheckboxButtonStyle(isChecked: isChecked))
    }
}

private struct System7CheckboxButtonStyle: ButtonStyle {
    
    @Environment(\.scaleFactor) var scaleFactor

    let isChecked: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        let image: ImageResource = switch (isChecked, configuration.isPressed) {
            case (true, true): .Checkbox.checkedSelected
            case (true, false): .Checkbox.checkedUnselected
            case (false, true): .Checkbox.uncheckedSelected
            case (false, false): .Checkbox.uncheckedUnselected
        }
        
        HStack(spacing: 4 * scaleFactor) {
            System7ScaleableImage(resource: image, width: 12, height: 12)
            configuration.label
                .system7FontLarge()
        }
        .contentShape(Rectangle())
    }
}

#Preview {
    struct System7CheckboxExample: View {
        @State var isChecked = false
        
        var body: some View {
            System7Checkbox(title: "Daylight Saving Time", isChecked: $isChecked)
        }
    }
    
    return System7CheckboxExample()
        .system7ScalablePadding()
        .environment(\.scaleFactor, 2)

}
