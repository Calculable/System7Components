import Foundation
import SwiftUI

public struct System7Slider: View {

    @Environment(\.scaleFactor) private var scaleFactor

    @Binding public var value: Double
    public let range: ClosedRange<Double>

    @State private var previousKnobOffset = 0.0
    @State private var knobOffset = 0.0

    init(value: Binding<Double>, range: ClosedRange<Double>) {
        self._value = value
        self.range = range
    }

    private var knobWidth: CGFloat {
        16.0*scaleFactor
    }
    private var knobPadding: CGFloat {
        5.0*scaleFactor
    }

    public var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule()
                    .foregroundColor(Color(.foreground))
                    .system7ScalablePadding(2)
                Capsule()
                    .foregroundColor(Color(.background))
                    .system7ScalablePadding(3)
                Capsule()
                    .system7ScalablePadding(4)
                System7ScaleableImage(resource: .Slider.sliderPattern, width: 4, height: 4, resizingMode: .tile)
                    .mask {
                        Capsule()
                    }
                    .system7ScalablePadding(5)
                System7ScaleableImage(resource: .Slider.sliderKnob, width: 15, height: 18)
                    .offset(x: knobOffset)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { gesture in
                                knobOffset = min(max(knobPadding, previousKnobOffset + gesture.translation.width), (geo.size.width - knobPadding) - knobWidth)
                            }
                            .onEnded { _ in
                                previousKnobOffset = knobOffset
                            }
                    )
            }
            .onChange(of: knobOffset) {
                value = updateSliderValueBasedOnOffset(availableWidth: geo.size.width)
            }
            .onAppear(perform: {
                knobOffset = updateOffsetBasedOnSliderValue(availableWidth: geo.size.width)
            })
        }
        .system7ScalableFrame(height: 18)
    }
    
    private func updateSliderValueBasedOnOffset(availableWidth: Double) -> Double {
        let minimumOffset = knobPadding
        let maximumOffset = (availableWidth - knobWidth) - knobPadding
        let availableKnobWidth = maximumOffset - minimumOffset
        
        let percentage = (knobOffset - minimumOffset) / (availableKnobWidth)
        return range.lowerBound + percentage * (range.lowerBound + range.upperBound)
    }
    
    private func updateOffsetBasedOnSliderValue(availableWidth: Double) -> Double {
        let minimumOffset = knobPadding
        let maximumOffset = (availableWidth - knobWidth) - knobPadding
        let availableKnobWidth = maximumOffset - minimumOffset
        
        let valueRange = range.upperBound - range.lowerBound
        let percentage = (value - range.lowerBound) / valueRange
        let knobOffset = minimumOffset + percentage * availableKnobWidth
        
        return knobOffset
    }
}


#Preview {
    struct System7SliderExample: View {
        
        @State var value = 0.0
        
        var body: some View {
            HStack {
                System7Slider(value: $value, range: 0.0...100.0)
                Text("\(value)")
            }
            
        }
    }
    
    return System7SliderExample()
        .system7ScalablePadding()
        .environment(\.scaleFactor, 2)

}
