import SwiftUI

struct ExpandableHorizontalGlassContainer<Content: View, Label: View>: View, Animatable {
    var placeAtLeading = false
    var isInteractive = true
    var size: CGSize = .init(width: 55, height: 55)
    var progress: CGFloat
    var state: WorkoutStage
    var labelProgressPadding: CGFloat = 0 // padding on the label when progress is 1.0
    @ViewBuilder var content: Content
    @ViewBuilder var label: Label
    @State private var labelPosition: CGRect = .zero
    @Namespace private var animation
    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }
    var body: some View {
        GlassEffectContainer(spacing: spacing) {
            HStack(spacing: spacing) {
                if placeAtLeading {
                    LabelView()
                }
                
                ForEach(subviews: content) { subview in
                    let unionID = subview.containerValues.unionID
                    let contentPadding = subview.containerValues.contentPadding
                    let width = size.width + (contentPadding * 2)
                    let tintColor = subview.containerValues.tintColor
                    subview
                        .blur(radius: 15 * scaleProgress)
                        .opacity(progress)
                        .frame(width: width, height: size.height)
                        .glassEffect(.regular.interactive(isInteractive).tint(tintColor), in: .capsule)
                        .glassEffectUnion(id: unionID, namespace: animation)
                        .allowsHitTesting(progress == 1)
                        .visualEffect { [labelPosition] content, proxy in
                            content.offset(x: offsetX(proxy: proxy, labelPosition: labelPosition))
                        }
                        .fixedSize()
                        .frame(width: width * progress)
                }
                
                if !placeAtLeading {
                    LabelView()
                }
            }
        }
        .coordinateSpace(.named("container"))
        .scaleEffect(x: 1 + scaleProgress * 0.3, y: 1 - scaleProgress * 0.3, anchor: .center)
    }
    
    nonisolated
    func offsetX(proxy: GeometryProxy, labelPosition: CGRect) -> CGFloat {
        let minX = labelPosition.minX - proxy.frame(in: .named("container")).minX
        return minX - (minX * progress)
    }
    
    @ViewBuilder
    private func LabelView() -> some View {
        label
            .compositingGroup()
            .blur(radius: 15 * scaleProgress)
            .frame(width: labelWidth, height: size.height)
            .glassEffect(.regular.interactive(isInteractive), in: .capsule)
            .onGeometryChange(for: CGRect.self) {
                $0.frame(in: .named("container"))
            } action: { newValue in
                labelPosition = newValue
            }
    }
    
    var labelWidth: CGFloat {
        size.width + (labelProgressPadding * 2) * labelProgressPaddingFactor
    }
    var labelProgressPaddingFactor: CGFloat {
        switch state {
        case .initial, .started, .picker: return progress
        default : return 0
        }
    }
    var scaleProgress: CGFloat { progress > 0.5 ? (1 - progress) / 0.5 : (progress / 0.5) }
    var spacing: CGFloat { 10.0 * progress }
}

extension ContainerValues {
    @Entry var unionID: String? = nil
    @Entry var contentPadding: CGFloat = 0
    @Entry var tintColor: Color? = nil
}

