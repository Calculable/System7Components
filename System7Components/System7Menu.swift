import Foundation
import SwiftUI

public struct System7MenuItemConfiguration: Identifiable {
    public let id = UUID()
    public let titleType: System7MenuTitleType
    public let items: [System7MenuItemType]

    public init(titleType: System7MenuTitleType, items: [System7MenuItemType]) {
        self.titleType = titleType
        self.items = items
    }
}

public enum System7MenuItemType {
    case separator
    case button(buttonItem: System7MenuButtonItem)
    
    public var isSelectable: Bool {
        switch self {
            case .separator:
                return false
            case .button(let buttonItem):
                return buttonItem.isSelectable
        }
    }
}

public enum System7MenuTitleType {
    case image(image: ImageResource, width: CGFloat, height: CGFloat)
    case text(title: String)
}

public struct System7MenuButtonItem {
    public let id: UUID
    public let title: String
    public let isSelectable: Bool

    public init(id: UUID = UUID(), title: String, isSelectable: Bool) {
        self.id = id
        self.title = title
        self.isSelectable = isSelectable
    }
}

public struct System7MenuBar: View {
    private let menus: [System7MenuItemConfiguration]
    private let onItemClicked: (System7MenuButtonItem) -> ()

    public init(menus: [System7MenuItemConfiguration], onItemClicked: @escaping (System7MenuButtonItem) -> Void) {
        self.menus = menus
        self.onItemClicked = onItemClicked
    }

    public var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            ForEach(menus) { menu in
                System7Menu(configuration: menu, onItemClicked: onItemClicked)
            }
            Spacer()
            System7Time()
                .system7ScalablePadding(.trailing, 10)
                .system7ScalablePadding(.bottom, 4)
            
        }
        .system7ScalablePadding(.leading, 12)
        .background(Color(.background))
        .zIndex(500)
    }
}

private struct System7Menu: View {
    
    let configuration: System7MenuItemConfiguration
    
    var isSelectable: Bool {
        configuration.items.contains(where: { $0.isSelectable })
    }
    
    @State var showsItems: Bool = false
    @State private var buttonSize: CGSize?

    let onItemClicked: (System7MenuButtonItem) -> ()

    var body: some View {
        System7OutsideTapListener(isActive: showsItems, dimmColor: Color.clear, content: {
            VStack(alignment: .leading, spacing: 0) {
                Button {
                    if isSelectable {
                        showsItems.toggle()
                    }
                } label: {
                    switch configuration.titleType {
                        case .image(let image, let width, let height):
                            System7ScaleableImage(resource: image, width: width, height: height)
                                .tint(.foreground)
                                .system7ScalablePadding(EdgeInsets(top: 2, leading: 5, bottom: 2, trailing: 5))
                        case .text(let title):
                            Text(title)
                                .system7FontLarge()
                                .system7ScalablePadding(EdgeInsets(top: 2, leading: 7, bottom: 4, trailing: 7))
                    }
                }.buttonStyle(System7MenuButtonStyle(isSelected: showsItems, isSelectable: isSelectable))
                    .modifier(ButtonSizeModifier())
                    .onPreferenceChange(ButtonSizeKey.self) { size in
                        self.buttonSize = size
                    }
                if showsItems {
                    System7MenuItems(items: configuration.items) { item in
                        showsItems = false
                        onItemClicked(item)
                    }
                }
            }
            .frame(width: buttonSize?.width, height: buttonSize?.height, alignment: .topLeading)
        }, onOutsideTap: {
            showsItems = false
        })
    }
}

private struct System7MenuButtonStyle: ButtonStyle {
    let isSelected: Bool
    let isSelectable: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        
        let isHighlighted = isSelected || configuration.isPressed
        
        let foregroundStyle = switch (isSelectable, isHighlighted) {
            case (false, _): Color(.gray300)
            case (true, false): Color(.foreground)
            case (true, true): Color(.background)
        }
        
        let background = switch (isSelectable, isHighlighted) {
            case (false, _): Color(.background)
            case (true, false): Color(.background)
            case (true, true): Color(.foreground)
        }
        
        configuration.label
            .foregroundStyle(foregroundStyle)
            .background(background)
    }
}

private struct System7MenuItems: View {
    let items: [System7MenuItemType]
    let onClick: (System7MenuButtonItem) -> ()

    @State var isSelected: Bool = false
    @State var highlightsOnHover: Bool = true
    @State var currentlyHoveredIndex: Int = -1
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                
                System7MenuItem(item: item, currentlyHoveredIndex: $currentlyHoveredIndex, id: index, onClick: onClick)
                    .onHover(perform: { isHovered in
                        if isHovered {
                            currentlyHoveredIndex = index
                        } else if currentlyHoveredIndex == index {
                            currentlyHoveredIndex = -1
                        }
                    })
            }
        }
        .fixedSize()
        .background(Color(.background))
        .system73DBorder()
    }
}

private struct System7MenuItem: View {
    
    let item: System7MenuItemType
    @Binding var currentlyHoveredIndex: Int
    var id: Int
    @State private var isHovered = false
    
    @State var isTemporarySelected: Bool = false
    
    let onClick: (System7MenuButtonItem) -> ()

    var body: some View {
        Group {

            switch item {
                case .separator:
                    Divider()
                        .foregroundStyle(Color(.gray300))
                        .system7ScalableFrame(maxWidth: .infinity)
                        .system7ScalablePadding(.vertical, 7)
                case .button(let buttonItem):
                    Button {
                        if item.isSelectable {
                            Task {
                                await blink(setBlinkStateOn: {
                                    isTemporarySelected = false
                                    isHovered = false
                                }, setBlinkStateOff: {
                                    isTemporarySelected = true
                                    isHovered = false
                                })
                                await MainActor.run {
                                    onClick(buttonItem)
                                }
                            }
                        }
                    } label: {
                        HStack(spacing: 0) {
                            Text(buttonItem.title)
                                .multilineTextAlignment(.leading)
                                .system7FontLarge()
                                .system7ScalablePadding(EdgeInsets(top: 3, leading: 15, bottom: 3, trailing: 11))

                            Spacer(minLength: 0)
                        }
                        .system7ScalableFrame(maxWidth: .infinity)
                    }
                    .buttonStyle(System7MenuButtonStyle(isSelected: isTemporarySelected || isHovered, isSelectable: item.isSelectable))
            }
        }
        .onChange(of: currentlyHoveredIndex) {
            isHovered = currentlyHoveredIndex == id
        }
    }
}

private struct System7Time: View {
    @State var isTime: Bool = true
    
    var body: some View {
        TimelineView(.periodic(from: .now, by: 1)) { context in
            let formatted = isTime ? context.date.formatted(date: .omitted, time: .shortened) : context.date.formatted(date: .numeric, time: .omitted)
            Text(formatted)
                .system7FontLarge()
        }.onTapGesture {
            isTime.toggle()
        }
    }
}

#Preview {
    VStack(spacing: 0) {

        let exampleConfiguration = [
            System7MenuItemConfiguration(titleType: .image(image: .Menubar.appleRainbow, width: 12, height: 15), items: []),
            System7MenuItemConfiguration(titleType: .text(title: "File"), items: [
                .button(buttonItem: .init(title: "New Folder", isSelectable: true)),
                .button(buttonItem: .init(title: "Open", isSelectable: true)),
                .button(buttonItem: .init(title: "Print", isSelectable: false)),
                .button(buttonItem: .init(title: "Close Window", isSelectable: true)),
                System7MenuItemType.separator,
                .button(buttonItem: .init(title: "Get Info", isSelectable: true)),
                .button(buttonItem: .init(title: "Sharing...", isSelectable: true))
            ]),
            System7MenuItemConfiguration(titleType: .text(title: "Edit"), items: [])
        ]
        
        System7MenuBar(menus: exampleConfiguration, onItemClicked: { item in
            print("Item \(item.title) clicked")
        })
        Color.gray
    }
    .loadCustomFonts()
    .environment(\.scaleFactor, 2)
    .padding()


}
