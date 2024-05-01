import SwiftUI

public struct System7StatusBar: View {
    
    private let leadingText: String?
    private let centerText: String?
    private let trailingText: String?

    public init(leadingText: String? = nil, centerText: String? = nil, trailingText: String? = nil) {
        self.leadingText = leadingText
        self.centerText = centerText
        self.trailingText = trailingText
    }

    public var body: some View {
        VStack(spacing: 1) {
            HStack {
                if let leadingText {
                    System7StatusBarText(text: leadingText)
                        .multilineTextAlignment(.leading)
                }
                
                Spacer()
                
                if let centerText {
                    System7StatusBarText(text: centerText)
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                
                if let trailingText {
                    System7StatusBarText(text: trailingText)
                        .multilineTextAlignment(.trailing)
                }
            }
            .system7ScalablePadding([.leading, .trailing], 9)
            
            Color(.background)
                .system7ScalableFrame(height: 3)
                .system7PlainBorder(color: .foreground)
        }
    }
}

private struct System7StatusBarText: View {
    let text: String
    
    var body: some View {
        Text(text)
            .system7FontSmall()
    }
}

#Preview("Status Bar") {
    System7StatusBar(leadingText: "9 items", centerText: "813.2 MB in disk", trailingText: "60.3 MB available")
        .environment(\.scaleFactor, 2)

}

#Preview("Status Bar (Only Center)") {
    System7StatusBar(leadingText: nil, centerText: "813.2 MB in disk", trailingText: nil)
        .environment(\.scaleFactor, 2)

}

