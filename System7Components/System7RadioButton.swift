import SwiftUI

struct System7RadioButtons<Item: CustomStringConvertible & Equatable & Hashable>: View {
    
    @Environment(\.scaleFactor) var scaleFactor


    let items: [Item]
    let layout: System7RadioLayout

    @Binding var selectedItem: Item
    
    var body: some View {
        switch layout {
            case .vertical:
                VStack(spacing: 8*scaleFactor) {
                    itemViews
                }
            case .horizontal:
                HStack(spacing: 16*scaleFactor) {
                    itemViews
                }
        }
    }
    
    var itemViews: some View {
        ForEach(items, id: \.self) { item in
            System7RadioButton(isChecked: item == selectedItem, title: item.description) {
                selectedItem = item
            }
        }
    }
}

enum System7RadioLayout {
    case vertical
    case horizontal
}

private struct System7RadioButton: View {
    let isChecked: Bool
    let title: String
    let onSelect: () -> ()
    
    var body: some View {
        Button(title) {
            onSelect()
        }
        .buttonStyle(System7RadioButtonStyle(isChecked: isChecked))
    }
}

private struct System7RadioButtonStyle: ButtonStyle {

    @Environment(\.scaleFactor) var scaleFactor

    let isChecked: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        let image: ImageResource = switch (isChecked, configuration.isPressed) {
            case (true, true): .RadioButton.checkedSelected
            case (true, false): .RadioButton.checkedUnselected
            case (false, true): .RadioButton.uncheckedSelected
            case (false, false): .RadioButton.uncheckedUnselected
        }
        
        HStack(spacing: 4*scaleFactor) {
            System7ScaleableImage(resource: image, width: 12, height: 12)
            
            configuration.label
                .system7FontLarge()
        }
        .contentShape(Rectangle())
    }
}

#Preview("Vertical") {
    struct System7VerticalRadioButtonsExample: View {
        
        let items = ["24 hour", "12 hour"]
        @State var selectedItem = "24 hour"
        
        var body: some View {
            System7RadioButtons(items: items, layout: .vertical, selectedItem: $selectedItem)
        }
    }
    
    return System7VerticalRadioButtonsExample()
        .system7ScalablePadding()
        .environment(\.scaleFactor, 2)

}

#Preview("Horizontal") {
    struct System7HorizontalRadioButtonsExample: View {
        
        let items = ["24 hour", "12 hour"]
        @State var selectedItem = "24 hour"
        
        var body: some View {
            System7RadioButtons(items: items, layout: .horizontal, selectedItem: $selectedItem)
        }
    }
    
    return System7HorizontalRadioButtonsExample()
        .system7ScalablePadding()
        .environment(\.scaleFactor, 2)

}
