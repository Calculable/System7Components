import SwiftUI

public struct System7DropDownPicker: View {

    private let fallbackTitle: String
    private let isAnimated: Bool
    @Binding private var selection: String?
    private let options: [String]

    @State private var showDropdown = false
    @State private var buttonSize: CGSize?

    public init(fallbackTitle: String, isAnimated: Bool, selection: Binding<String?>, options: [String]) {
        self.fallbackTitle = fallbackTitle
        self.isAnimated = isAnimated
        self._selection = selection
        self.options = options
    }

    public var body: some View {
        System7OutsideTapListener(isActive: showDropdown, dimmColor: Color.clear, content: {
            VStack(spacing: 0) {
                System7DropDownItem(text: selection ?? fallbackTitle, image: showDropdown ? nil : Image(.Picker.pickerChevronDown)) {
                    if isAnimated {
                        withAnimation(.easeIn(duration: 0.2)) {
                            showDropdown.toggle()
                        }
                    } else {
                        showDropdown.toggle()
                    }
                }
                .modifier(ButtonSizeModifier())
                .onPreferenceChange(ButtonSizeKey.self) { size in
                    self.buttonSize = size
                }
                if showDropdown {
                    System7OptionsView(options: options, selection: $selection, isAnimated: isAnimated) {
                        showDropdown.toggle()
                    }
                }
            }
            .clipped()
            .system73DBorder()
            .frame(width: buttonSize?.width, height: buttonSize?.height, alignment: .top)
        }, onOutsideTap: {
            showDropdown = false
        })
    }
}

private struct System7DropDownButtonStyle: ButtonStyle {
    
    let image: Image?
    let isHighlighted: Bool
    
    func makeBody(configuration: Self.Configuration) -> some View {
        let isHighlighted = configuration.isPressed || isHighlighted
        
        HStack {
            configuration.label
                .foregroundStyle(Color(isHighlighted ? .background : .foreground))
                .system7FontLarge()
            Spacer()
            if let image {
                image
                    .interpolation(.none)
            }
        }
        .system7ScalablePadding(.horizontal, 7)
        .system7ScalablePadding(.vertical, 3)
        .background(isHighlighted ? Color(.foreground) : Color(.background))
    }
}

private struct System7DropDownItem: View {
    
    let text: String
    let image: Image?
    
    @Binding var currentlyHoveredIndex: Int
    let id: Int
    @State private var isHovered = false
    
    let highlightsOnHover: Bool
    let blinksOnSelection: Bool
    
    let action: () -> ()
    
    @State private var isHighlighted: Bool = false
    
    init(text: String, image: Image?, currentlyHoveredIndex: Binding<Int>, id: Int, highlightsOnHover: Bool, blinksOnSelection: Bool, action: @escaping () -> Void) {
        self.text = text
        self.image = image
        self._currentlyHoveredIndex = currentlyHoveredIndex
        self.id = id
        self.highlightsOnHover = highlightsOnHover
        self.blinksOnSelection = blinksOnSelection
        self.action = action
    }
    
    init(text: String, image: Image?, action: @escaping () -> Void) {
        self.text = text
        self.image = image
        self._currentlyHoveredIndex = .constant(-1)
        self.id = -1
        self.highlightsOnHover = false
        self.blinksOnSelection = false
        self.action = action
    }
    
    var body: some View {
        Button(text) {
            Task {
                if blinksOnSelection {
                    await blink(setBlinkStateOn: {
                        isHighlighted = true
                        isHovered = false
                    }, setBlinkStateOff: {
                        isHighlighted = false
                        isHovered = false
                    })
                }
                await MainActor.run {
                    action()
                }
            }
        }.buttonStyle(System7DropDownButtonStyle(image: image, isHighlighted: isHighlighted || isHovered))
            .onChange(of: currentlyHoveredIndex) {
                isHovered = currentlyHoveredIndex == id
            }
    }
}

private struct System7OptionsView: View {
    
    let options: [String]
    @Binding var selection: String?
    let isAnimated: Bool
    
    let dismiss: () -> ()
    
    @State private var currentlyHoveredIndex: Int = -1
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(Array(options.enumerated()), id: \.offset) { index, option in
                System7DropDownItem(text: option, image: nil, currentlyHoveredIndex: $currentlyHoveredIndex, id: index, highlightsOnHover: true, blinksOnSelection: true) {
                    if isAnimated {
                        withAnimation(.easeIn(duration: 0.2)) {
                            selection = option
                            dismiss()
                        }
                    } else {
                        selection = option
                        dismiss()
                    }
                }
                .onHover(perform: { isHovered in
                    if isHovered {
                        currentlyHoveredIndex = index
                    } else if currentlyHoveredIndex == index {
                        currentlyHoveredIndex = -1
                    }
                })
                .animation(.none, value: selection)
            }
        }
        .transition(.move(edge: .top))
        .zIndex(1000)
    }
}

#Preview {
    struct System7PickerExample: View {
        
        @State var selection: String? = nil
        
        var body: some View {
            System7DropDownPicker(
                fallbackTitle: "Select",
                isAnimated: false,
                selection: $selection,
                options: [
                    "First",
                    "Second",
                    "Third",
                    "Forth"
                ]
            )
            .system7ScalableFrame(width: 150)
            .zIndex(1000)
        }
    }
    
    return System7PickerExample()
        .system7ScalablePadding(100)
        .environment(\.scaleFactor, 2)

}
