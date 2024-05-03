import Foundation
import SwiftUI

public struct System7AlertWithButtons: View {
    private let title: String
    private let symbol: System7AlertSymbol
    private let buttonConfigurations: [System7AlertButtonConfiguration]

    @State private var buttonMaxWidth: CGFloat?

    public init(title: String, symbol: System7AlertSymbol, buttonConfigurations: [System7AlertButtonConfiguration]) {
        self.title = title
        self.symbol = symbol
        self.buttonConfigurations = buttonConfigurations
    }

    public var body: some View {
        System7Alert(text: title, symbol: symbol) {
            ForEach(buttonConfigurations) { buttonConfiguration in
                Button(action: {}, label: {
                    Text(buttonConfiguration.title)
                        .frame(width: buttonMaxWidth)
                        .background(GeometryReader { geometry in
                            Color.clear.preference(
                                key: ButtonWidthPreferenceKey.self,
                                value: geometry.size.width
                            )
                        })
                }).if(buttonConfiguration.isPrimary, transform: { view in
                    view.buttonStyle(System7PrimaryButtonStyle())
                })
                .if(buttonConfiguration.isPrimary == false, transform: { view in
                    view.buttonStyle(System7ButtonStyle())
                })
            }
            .onPreferenceChange(ButtonWidthPreferenceKey.self) {
                buttonMaxWidth = $0
            }
        }
    }
}

public struct System7AlertButtonConfiguration: Identifiable {
    public let id = UUID()
    public let title: String
    public let isPrimary: Bool
    public let action: () -> ()
}

public enum System7AlertSymbol {
    case none
    case stop
    case warningBlackAndWhite
    case warningYellow
}


private struct ButtonWidthPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat,
                       nextValue: () -> CGFloat) {
        //Bei mehreren Texten wird der maximale Wert genommen
        print("received: \(value) with next: \(nextValue())")
        value = max(value, nextValue())
    }
}

private struct System7Alert<T: View>: View {
    
    let text: String
    let symbol: System7AlertSymbol
    
    @ViewBuilder let additionalView: () -> T
    
    var body: some View {
        System7AlertFrame {
            VStack(alignment: .leading, spacing: 30) {
                HStack(alignment: .top, spacing: 23) {
                    if let symbolImage {
                        System7ScaleableImage(resource: symbolImage, width: 32, height: 32)
                    }
                    Text(text)
                        .system7FontLarge()
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                HStack(spacing: 10) {
                    Spacer()
                    additionalView()
                }
            }
        }
    }
    
    var symbolImage: ImageResource? {
        switch symbol {
        case .none:
            nil
        case .stop:
            .Alert.stop
        case .warningBlackAndWhite:
            .Alert.warningBlackAndWhite
        case .warningYellow:
            .Alert.warning
        }
    }
}

private struct System7AlertFrame<Content: View>: View {
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        System7OutsideTapListener(isActive: true, dimmColor: Color(.gray100).opacity(0.4), content: {
            content()
                .safeAreaPadding(EdgeInsets(top: 18, leading: 18, bottom: 16, trailing: 18))
            
                .system7ModalBorder()
                .background {
                    Color(.background)
                }
        }) {
            //Play alert sound
        }
        
    }
}

extension View {
    /// Source: https://www.avanderlee.com/swiftui/conditional-view-modifier/
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

#Preview {
    VStack {
        System7AlertWithButtons(title: "The disk could not be erased, because you cannot erase a shared disk", symbol: .stop, buttonConfigurations: [
            System7AlertButtonConfiguration(title: "Cancel", isPrimary: false, action: {
                print("Cancel called")
            }),
            System7AlertButtonConfiguration(title: "OK", isPrimary: true, action: {
                print("OK called")
            })
            
        ])
        .system7ScalablePadding()
        
        Button("Views outside can not be clicked") {}
    }
    .loadCustomFonts()
    .environment(\.scaleFactor, 2)


    
}
