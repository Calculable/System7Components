import SwiftUI

//Workaround until apple allowes to set assets in external package to public: https://forums.swift.org/t/generate-images-and-colors-inside-a-swift-package/65674/17
public struct PublicColors {
    public static var gray100 = Color(.gray100)
    public static var gray200 = Color(.gray200)
    public static var gray300 = Color(.gray300)
    public static var gray400 = Color(.gray400)
    public static var gray500 = Color(.gray500)

    public static var lavender100 = Color(.lavender100)
    public static var lavender200 = Color(.lavender200)
    public static var lavender300 = Color(.lavender300)
    public static var lavender500 = Color(.lavender500)

    public static var foreground = Color(.foreground)
    public static var background = Color(.background)

}
