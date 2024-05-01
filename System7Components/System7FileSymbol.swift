import Foundation
import SwiftUI
import Flow

public struct System7FileSymbol: View {
    private let fileType: System7FileType
    private let isSelected: Bool
    private let isOpen: Bool

    public init(fileType: System7FileType, isSelected: Bool = false, isOpen: Bool = false) {
        self.fileType = fileType
        self.isSelected = isSelected
        self.isOpen = isOpen
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            if let icon = fileType.icon {
                System7ScaleableImage(resource: icon, width: fileType.width, height: fileType.height)
                    .overlay(
                        Group {
                            if isOpen {
                                System7ScaleableImage(resource: isSelected ? .Icons.openIconPatternSelected : .Icons.openIconPatternUnselected, width: 4, height: 4, resizingMode: .tile)

                            } else {
                                EmptyView()
                            }
                        }
                    )
                    .system7PNGShapedBorder(image: icon, imageWidth: fileType.width, imageHeight: fileType.height, width: 1, color: Color(.foreground), isActive: isOpen)
                    .brightness(isSelected ? (isOpen ? 0 : -0.5) : 0)
                    .system7ScalablePadding(isOpen ? 0 : 1)
            } else {
                ZStack {}
                    .system7ScalableFrame(width: 31, height: 31)
            }
            
            if let name = fileType.name {
                Text(name)
                    .system7FontSmall()
                    .foregroundStyle(isSelected ? Color(.background) : Color(.foreground))
                    .system7ScalablePadding(1)
                    .background {
                        if isSelected {
                            Color(.foreground)
                        } else {
                            Color(.background)
                        }
                    }
            }
        }
    }
}


public enum System7FileType {
    case custom(customImage: ImageResource, customName: String, width: CGFloat, height: CGFloat)
    case appleMenuItems
    case controlPanels
    case emptySpace
    case extensions
    case finder
    case file(customName: String)
    case folder(customName: String)
    case fonts
    case launcherItems
    case macTCPDnr
    case preferences
    case scrapbookFile
    case shutdownItems
    case startupItems
    case system
    case trashcan
    
    public var name: String? {
        switch self {
            case .custom(_, let customName, _, _):
                customName
            case .appleMenuItems:
                "Apple Menu Items"
            case .controlPanels:
                "Control Panels"
            case .emptySpace:
                nil
            case .extensions:
                "Extensions"
            case .finder:
                "Finder"
            case .file(let customName):
                customName
            case .folder(let customName):
                customName
            case .fonts:
                "Fonts"
            case .launcherItems:
                "Launcher Items"
            case .macTCPDnr:
                "MacTCP DNR"
            case .preferences:
                "Preferences"
            case .scrapbookFile:
                "Scrapbook File"
            case .shutdownItems:
                "Shutdown Items"
            case .startupItems:
                "Startup Items"
            case .system:
                "System"
            case .trashcan:
                "Trash"
        }
    }
    
    var icon: ImageResource? {
       switch self {
        case .custom(let customImage, _, _, _):
            customImage
        case .appleMenuItems:
           .Icons.appleMenuItems
        case .controlPanels:
            .Icons.controlPanels
        case .emptySpace:
            nil
        case .extensions:
            .Icons.extensions
        case .finder:
            .Icons.finder
        case .file:
            .Icons.file
        case .folder:
            .Icons.folder
        case .fonts:
            .Icons.fonts
        case .launcherItems:
            .Icons.launcherItems
        case .macTCPDnr:
            .Icons.macTCPDnr
        case .preferences:
            .Icons.preferences
        case .scrapbookFile:
            .Icons.scrapbookFile
        case .shutdownItems:
            .Icons.shutdownStartupItems
        case .startupItems:
            .Icons.shutdownStartupItems
        case .system:
            .Icons.system
        case .trashcan:
            .Icons.trashcan
        }
    }

    var width: CGFloat {
        switch self {
            case .custom(_, _, let width, _):
                width
            case .appleMenuItems:
                31
            case .controlPanels:
                31
            case .emptySpace:
                31
            case .extensions:
                31
            case .finder:
                24
            case .file:
                25
            case .folder:
                31
            case .fonts:
                31
            case .launcherItems:
                31
            case .macTCPDnr:
                25
            case .preferences:
                31
            case .scrapbookFile:
                30
            case .shutdownItems:
                31
            case .startupItems:
                31
            case .system:
                31
            case .trashcan:
                17
        }
    }

    var height: CGFloat {
        switch self {
            case .custom(_, _, _, let height):
                height
            case .appleMenuItems:
                25
            case .controlPanels:
                25
            case .emptySpace:
                31
            case .extensions:
                25
            case .finder:
                31
            case .file:
                32
            case .folder:
                25
            case .fonts:
                25
            case .launcherItems:
                25
            case .macTCPDnr:
                32
            case .preferences:
                25
            case .scrapbookFile:
                25
            case .shutdownItems:
                25
            case .startupItems:
                25
            case .system:
                25
            case .trashcan:
                25
        }
    }
}

#Preview {
    HStack {
        System7FileSymbol(fileType: .appleMenuItems)
        System7FileSymbol(fileType: .folder(customName: "MyFolder"))
        System7FileSymbol(fileType: .folder(customName: "Selected"), isSelected: true)
        System7FileSymbol(fileType: .folder(customName: "Open"), isOpen: true)
        System7FileSymbol(fileType: .folder(customName: "Selected and Open"), isSelected: true, isOpen: true)
        System7FileSymbol(fileType: .folder(customName: "MyFolder"))
        System7FileSymbol(fileType: .file(customName: "MyFile"))
        System7FileSymbol(fileType: .custom(customImage: ._16974, customName: "MyFile", width: 30, height: 30))
    }
    .system7ScalablePadding()
    .environment(\.scaleFactor, 2)

}
