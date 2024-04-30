import SwiftUI

struct System7WindowAnimationBorder: View {

    @Environment(\.scaleFactor) var scaleFactor

    let isOpenAnimation: Bool
    let originX: CGFloat
    let originY: CGFloat

    @State var currentPositionX = 0.0
    @State var currentPositionY = 0.0
    @State var currentWidth = 0.0
    @State var currentHeight = 0.0


    let onCompletion: (() -> ())?

    var body: some View {
        GeometryReader { geo in
            Rectangle()
                .strokeBorder(style: StrokeStyle(lineWidth: 1*scaleFactor, dash: [1*scaleFactor]))
                .frame(width: currentWidth, height: currentHeight)
                .position(x: currentPositionX, y: currentPositionY)
                .onAppear {
                    currentPositionX = isOpenAnimation ? originX : geo.size.width / 2
                    currentPositionY = isOpenAnimation ? originY : geo.size.height / 2
                    currentWidth = isOpenAnimation ? 0 : geo.size.width
                    currentHeight = isOpenAnimation ? 0 : geo.size.height

                    withAnimation(.linear(duration: 0.2)) {
                        currentWidth = isOpenAnimation ? geo.size.width : 0
                        currentHeight = isOpenAnimation ? geo.size.height : 0
                        currentPositionX = isOpenAnimation ? geo.size.width / 2 : originX
                        currentPositionY = isOpenAnimation ? geo.size.height / 2 : originY
                    } completion: {
                        onCompletion?()
                    }
                }
        }
    }
}
