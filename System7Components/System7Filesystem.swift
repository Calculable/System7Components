import SwiftUI
import Flow

@Observable
public class System7FileModel: Identifiable {
    public let id: UUID
    public var symbol: System7FileType
    public var isSelected: Bool = false
    public var isOpen: Bool = false
    public var offsetX: CGFloat = 0
    public var offsetY: CGFloat = 0

    public init(id: UUID, symbol: System7FileType) {
        self.id = id
        self.symbol = symbol
    }
}


public enum System7FileMode {
    case onDesktop
    case insideFolder
}

private struct ButtonAnchorPreferenceKey: PreferenceKey {
    typealias Value = [UUID: Anchor<CGPoint>]

    static var defaultValue: Value = [:]

    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.merge(nextValue(), uniquingKeysWith: { (current, _) in current })
    }
}


public struct System7Filesystem: View {

    @Environment(\.scaleFactor) var scaleFactor

    @Binding private var files: [System7FileModel]

    @State private var filePositions: [UUID: Anchor<CGPoint>] = [:]

    private let mode: System7FileMode
    private let onOpen: (_ file: System7FileModel, _ originAnchor: Anchor<CGPoint>) -> ()


    public init(files: Binding<[System7FileModel]>, mode: System7FileMode, onOpen: @escaping (_: System7FileModel, _: Anchor<CGPoint>) -> Void) {
        self._files = files
        self.mode = mode
        self.onOpen = onOpen
    }

    private var frameAlignment: Alignment {
        switch mode {
            case .onDesktop:
                    .topTrailing
            case .insideFolder:
                    .topLeading
        }
    }

    public var body: some View {
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

                .highPriorityGesture(
                    TapGesture()
                        .onEnded { _ in
                            deselectAllFiles()
                            file.isSelected = true
                        }
                )
                .simultaneousGesture(TapGesture(count: 2)
                    .onEnded({ _ in
                        deselectAllFiles()
                        file.isSelected = true

                        guard let anchor = filePositions[file.id] else {
                            assertionFailure("File Position not found")
                            return
                        }

                        onOpen(file, anchor)
                    }))
              

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
