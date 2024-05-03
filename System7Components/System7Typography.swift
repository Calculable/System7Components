import SwiftUI

extension View {

    public func system7FontDisplay() -> some View {
        modifier(System7DisplayFont())
    }
    
    public func system7FontLarge() -> some View {
        self
            .modifier(System7LargeFont())
    }
    
    public func system7FontSmall() -> some View {
        modifier(System7SmallFont())
    }

    public func loadCustomFonts() -> some View {
        for font in ["EBGaramond-Regular.ttf", "TitilliumWeb-Bold.ttf"] {
            guard let url = Bundle(identifier: "ch.janhuber.System7Components")!.url(forResource: font, withExtension: nil) else { return self }
                    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
                }
        return self
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
        .loadCustomFonts()
        .system7FontDisplay()
        .system7ScalablePadding()
        .environment(\.scaleFactor, 2)

}

#Preview("Large Font") {

    VStack {
        Text("Large")
            .loadCustomFonts()
            .system7FontLarge()
            .system7ScalablePadding()
            .environment(\.scaleFactor, 2)

    }

}

#Preview("Small Font") {
    Text("Small")
        .loadCustomFonts()
        .system7FontSmall()
        .system7ScalablePadding()
        .environment(\.scaleFactor, 2)

}
