import Foundation
import SwiftUI
import Flow

struct System7Background: View {

    @Environment(\.scaleFactor) var scaleFactor

    enum System7BackgroundImage: String, CaseIterable {
        case defaultBackground = "defaultBackground"
        case background10042 = "10042"
        case background1111 = "1111"
        case background11703 = "11703"
        case background12484 = "12484"
        case background12593 = "12593"
        case background128 = "128"
        case background12821 = "12821"
        case background129 = "129"
        case background130 = "130"
        case background13096 = "13096"
        case background131 = "131"
        case background132 = "132"
        case background133 = "133"
        case background134 = "134"
        case background136 = "136"
        case background13665 = "13665"
        case background137 = "137"
        case background139 = "139"
        case background141 = "141"
        case background142 = "142"
        case background144 = "144"
        case background145 = "145"
        case background146 = "146"
        case background147 = "147"
        case background148 = "148"
        case background149 = "149"
        case background150 = "150"
        case background151 = "151"
        case background16825 = "16825"
        case background16974 = "16974"
        case background17803 = "17803"
        case background18078 = "18078"
        case background19688 = "19688"
        case background1969 = "1969"
        case background1970 = "1970"
        case background1971 = "1971"
        case background1972 = "1972"
        case background1973 = "1973"
        case background1974 = "1974"
        case background1975 = "1975"
        case background1976 = "1976"
        case background1977 = "1977"
        case background1978 = "1978"
        case background20318 = "20318"
        case background20446 = "20446"
        case background21225 = "21225"
        case background22348 = "22348"
        case background23295 = "23295"
        case background24517 = "24517"
        case background24642 = "24642"
        case background24817 = "24817"
        case background2767 = "2767"
        case background28851 = "28851"
        case background28920 = "28920"
        case background29907 = "29907"
        case background30711 = "30711"
        case background30930 = "30930"
        case background31689 = "31689"
        case background32307 = "32307"
        case background32623 = "32623"
        case background3727 = "3727"
        case background4193 = "4193"
        case background547 = "547"
        case background6006 = "6006"
        case background6741 = "6741"
        case background7041 = "7041"
        case background7321 = "7321"
        case background7344 = "7344"
        case background7527 = "7527"
        case background8388 = "8388"
        case background8448 = "8448"
        case background870 = "870"
        case background9695 = "9695"
        case background987 = "987"
    }
    
    let background: System7BackgroundImage
    
    var body: some View {
        Image(background.rawValue)
            .interpolation(.none)
            .resizable(resizingMode: .tile)
    }
}

#Preview {
    System7Background(background: .background31689)
        .environment(\.scaleFactor, 2)

}
