import SwiftUI

extension View {

    func system7FontDisplay() -> some View {
        modifier(System7DisplayFont())
    }
    
    func system7FontLarge() -> some View {
        self
            .modifier(System7LargeFont())
    }
    
    func system7FontSmall() -> some View {
        modifier(System7SmallFont())
    }
}

fileprivate struct System7DisplayFont: ViewModifier {

    @Environment(\.scaleFactor) var scaleFactor

    func body(content: Content) -> some View {
        content
            .font(.custom("EBGaramond-Regular", size: 72*scaleFactor, relativeTo: .largeTitle))
    }
}

fileprivate struct System7LargeFont: ViewModifier {

    @Environment(\.scaleFactor) var scaleFactor


    func body(content: Content) -> some View {
        content
            .font(.custom("TitilliumWeb-Bold", size: 12*scaleFactor, relativeTo: .headline)) //would actually be Chicaco but since it is not a system font, we use TitilliumWeb instead
            .system7ScalablePadding(.vertical, (-4))

    }
}

fileprivate struct System7SmallFont: ViewModifier {

    @Environment(\.scaleFactor) var scaleFactor

    func body(content: Content) -> some View {
        content
            .font(.custom("Geneva", size: 9*scaleFactor, relativeTo: .body))
    }
}

#Preview("Display Font") {
    Text("Display")
        .system7FontDisplay()
        .system7ScalablePadding()
}

#Preview("Large Font") {

    VStack {
        Text("Large")
            .system7FontLarge()
            .background(.red)
            .system7ScalablePadding()
    }

}

#Preview("Small Font") {
    Text("Small")
        .system7FontSmall()
        .system7ScalablePadding()
}
