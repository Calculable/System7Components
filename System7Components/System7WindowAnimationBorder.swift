import SwiftUI

public struct System7WindowAnimationBorder: View {

    @Environment(\.scaleFactor) private var scaleFactor

    private let isOpenAnimation: Bool
    private let originX: CGFloat
    private let originY: CGFloat
    private let onCompletion: (() -> ())?

    @State private var currentPositionX = 0.0
    @State private var currentPositionY = 0.0
    @State private var currentWidth = 0.0
    @State private var currentHeight = 0.0

    public init(isOpenAnimation: Bool, originX: CGFloat, originY: CGFloat, onCompletion: (() -> Void)?) {
        self.isOpenAnimation = isOpenAnimation
        self.originX = originX
        self.originY = originY
        self.onCompletion = onCompletion
    }

    public var body: some View {
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
