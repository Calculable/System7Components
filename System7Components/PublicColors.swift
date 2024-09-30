import SwiftUI

//Workaround until apple allowes to set assets in external package to public: https://forums.swift.org/t/generate-images-and-colors-inside-a-swift-package/65674/17
public struct PublicColors {
    public static var lavender500 = Color(.lavender500)
    public static var gray100 = Color(.gray100)
    public static var foreground = Color(.foreground)

    public static var background = Color(.background)

}
