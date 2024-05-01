import Foundation
import SwiftUI

public struct System7LabeledContent<Content: View>: View {

    @Environment(\.scaleFactor) private var scaleFactor

    private let title: String
    @ViewBuilder private let content: () -> Content

    init(title: String, content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .system7FontSmall()
                .background(Color(.background))
                .offset(x: 15*scaleFactor, y: 6*scaleFactor)
                .zIndex(1)
            content()
                .system7ScalablePadding(EdgeInsets(top: 10, leading: 10, bottom: 8, trailing: 25))
                .overlay {
                    Rectangle()
                        .strokeBorder(Color(.gray300), style: StrokeStyle(lineWidth: 1*scaleFactor, dash: [1*scaleFactor], dashPhase: 1*scaleFactor))
                        .strokeBorder(Color(.gray400), style: StrokeStyle(lineWidth: 1*scaleFactor, dash: [1], dashPhase: 0))
                }
                .zIndex(0)
        }
    }
}

#Preview {
    System7LabeledContent(title: "Translation Choices Dialog box") {
        VStack(alignment: .leading) {
            System7Checkbox(title: "Always show dialog box", isChecked: .constant(true))
            System7Checkbox(title: "Include applications on servers", isChecked: .constant(false))
            System7Checkbox(title: "Auto pick if only 1 choice", isChecked: .constant(false))
            
        }
    }
    .system7ScalablePadding()
    .environment(\.scaleFactor, 2)

}
