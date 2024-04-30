import SwiftUI
import Flow

@Observable
class System7FileModel: Identifiable {
    let id: UUID
    var symbol: System7FileType
    var isSelected: Bool = false
    var isOpen: Bool = false
    var offsetX: CGFloat = 0
    var offsetY: CGFloat = 0

    init(id: UUID, symbol: System7FileType) {
        self.id = id
        self.symbol = symbol
    }
}


enum System7FileMode {
    case onDesktop
    case insideFolder
}

struct ButtonAnchorPreferenceKey: PreferenceKey {
    typealias Value = [UUID: Anchor<CGPoint>]

    static var defaultValue: Value = [:]

    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.merge(nextValue(), uniquingKeysWith: { (current, _) in current })
    }
}


struct System7Filesystem: View {

    @Environment(\.scaleFactor) var scaleFactor

    @Binding var files: [System7FileModel]

    @State private var filePositions: [UUID: Anchor<CGPoint>] = [:]

    let mode: System7FileMode
    let onOpen: (_ file: System7FileModel, _ originAnchor: Anchor<CGPoint>) -> ()


    private var frameAlignment: Alignment {
        switch mode {
            case .onDesktop:
                    .topTrailing
            case .insideFolder:
                    .topLeading
        }
    }

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .center) {
                switch mode {
                    case .onDesktop:
                        VFlow(alignment: .center) {
                            filesView
                        }
                        .environment(\.layoutDirection, .rightToLeft)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: frameAlignment)
                    case .insideFolder:
                        HFlow(alignment: .center) {
                            filesView
                        }
                        .environment(\.layoutDirection, .leftToRight)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: frameAlignment)
                }
            }
            .onTapGesture {
                deselectAllFiles()
            }
            .onPreferenceChange(ButtonAnchorPreferenceKey.self) { preferences in
                for (index, anchor) in preferences {
                    filePositions[index] = anchor
                }
            }
        }
    }

    private var filesView: some View {
        ForEach(files) { file in
            System7FileSymbol(fileType: file.symbol, isSelected: file.isSelected, isOpen: file.isOpen)

                .onTapGesture(count: 2) {
                    deselectAllFiles()
                    file.isSelected = true
                    file.isOpen = true

                    guard let anchor = filePositions[file.id] else {
                        assertionFailure("File Position not found")
                        return
                    }

                    onOpen(file, anchor)
                }
                .simultaneousGesture(
                    TapGesture()
                        .onEnded { _ in
                            deselectAllFiles()
                            file.isSelected = true
                        }
                )
                .background(GeometryReader { buttonGeometry in
                    Color.clear
                    // Step 2: Capture the layout of each button
                        .anchorPreference(key: ButtonAnchorPreferenceKey.self, value: .center) { anchor in
                            // Create a dictionary with the button's index and its center anchor
                            [file.id: anchor]
                        }
                })
        }
    }

    private func deselectAllFiles() {
        files.forEach {
            $0.isSelected = false
        }
    }
}
