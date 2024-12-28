import Foundation
import SwiftUI
import Flow

public struct System7Background: View {

    @Environment(\.scaleFactor) private var scaleFactor

    public enum System7BackgroundImage: String, CaseIterable {
        case defaultBackground = "defaultBackground"
        case background10042 = "10042"
        case background1111 = "1111"
        case background11703 = "11703"
        case background12484 = "12484"
        case background12593 = "12593"
        case background128 = "128"
        case background12821 = "12821"
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

        public var imageResource: ImageResource {
            switch self {
                case .defaultBackground: .defaultBackground
                case .background10042: ._10042
                case .background1111: ._1111
                case .background11703: ._11703
                case .background12484: ._12484
                case .background12593: ._12593
                case .background128: ._128
                case .background12821: ._12821
                case .background130: ._130
                case .background13096: ._13096
                case .background131: ._131
                case .background132: ._132
                case .background133: ._133
                case .background134: ._134
                case .background136: ._136
                case .background13665: ._13665
                case .background137: ._137
                case .background139: ._139
                case .background141: ._141
                case .background142: ._142
                case .background144: ._144
                case .background145: ._145
                case .background146: ._146
                case .background147: ._147
                case .background148: ._148
                case .background149: ._149
                case .background150: ._150
                case .background151: ._151
                case .background16825: ._16825
                case .background16974: ._16974
                case .background17803: ._17803
                case .background18078: ._18078
                case .background19688: ._19688
                case .background1969: ._1969
                case .background1970: ._1970
                case .background1971: ._1971
                case .background1972: ._1972
                case .background1973: ._1973
                case .background1974: ._1974
                case .background1975: ._1975
                case .background1976: ._1976
                case .background1977: ._1977
                case .background1978: ._1978
                case .background20318: ._20318
                case .background20446: ._20446
                case .background21225: ._21225
                case .background22348: ._22348
                case .background23295: ._23295
                case .background24517: ._24517
                case .background24642: ._24642
                case .background24817: ._24817
                case .background2767: ._2767
                case .background28851: ._28851
                case .background28920: ._28920
                case .background29907: ._29907
                case .background30711: ._30711
                case .background30930: ._30930
                case .background31689: ._31689
                case .background32307: ._32307
                case .background32623: ._32623
                case .background3727: ._3727
                case .background4193: ._4193
                case .background547: ._547
                case .background6006: ._6006
                case .background6741: ._6741
                case .background7041: ._7041
                case .background7321: ._7321
                case .background7344: ._7344
                case .background7527: ._7527
                case .background8388: ._8388
                case .background8448: ._8448
                case .background870: ._870
                case .background9695: ._9695
                case .background987: ._987
            }
        }
    }


    public let background: System7BackgroundImage

    public init(background: System7BackgroundImage) {
        self.background = background
    }

    public var body: some View {
        Image(background.imageResource)
            .interpolation(.none)
            .resizable(resizingMode: .tile)
    }
}

#Preview {
    System7Background(background: .background142)
        .environment(\.scaleFactor, 2)

}
