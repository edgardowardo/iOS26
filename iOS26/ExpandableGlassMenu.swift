import SwiftUI

struct ExpandableGlassMenu<Content: View, Label: View>: View, Animatable {
    var menuAlignment: Alignment = .bottom
    var progress: CGFloat
    var labelSize: CGSize = .init(width: 55, height: 55)
    var cornerRadius: CGFloat = 30
    @ViewBuilder var menuContent: Content
    @ViewBuilder var label: Label
    @State private var menuContentSize: CGSize = .zero
    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }

    var body: some View {
        GlassEffectContainer {
            let widthDiff = menuContentSize.width - labelSize.width
            let heightDiff = menuContentSize.height - labelSize.height
            let rWidth = widthDiff * menuContentOpacity
            let rHeight = heightDiff * menuContentOpacity
            
            ZStack(alignment: menuAlignment) {
                menuContent
                    .compositingGroup()
                    .scaleEffect(menuContentScale)
                    .blur(radius: 14 * blurProgress)
                    .opacity(menuContentOpacity)
                    .onGeometryChange(for: CGSize.self) {
                        $0.size
                    } action: { newValue in
                        menuContentSize = newValue
                    }
                    .fixedSize()
                    .frame(width: labelSize.width + rWidth,
                           height: labelSize.height + rHeight)
                label
                    .compositingGroup()
                    .blur(radius: 14 * blurProgress)
                    .opacity(1 - labelOpacity)
                    .frame(width: labelSize.width, height: labelSize.height)
            }
            .compositingGroup()
            .clipShape(.rect(cornerRadius: cornerRadius))
            .glassEffect(.regular.interactive(), in: .rect(cornerRadius: cornerRadius))
        }
        .scaleEffect(
            x: 1 - blurProgress * 0.35,
            y: 1 + blurProgress * 0.45,
            anchor: scaleAnchor
        )
        .offset(y: offset * blurProgress)
    }
    
    // menu related properties
    var labelOpacity: CGFloat { min(progress / 0.35, 1) }
    var menuContentOpacity: CGFloat { max(progress - 0.35, 0) / 0.65 }
    var menuContentScale: CGFloat {
        let minAspectScale = min(labelSize.width / menuContentSize.width, labelSize.height / menuContentSize.height)
        return minAspectScale + (1 - minAspectScale) * progress
    }
    var blurProgress: CGFloat { progress > 0.5 ? (1 - progress) / 0.5 : progress / 0.5 }
    var offset: CGFloat {
        switch menuAlignment {
        case .bottom, .bottomLeading, .bottomTrailing: -75
        case .top, .topLeading, .topTrailing: 75
        default: 0
        }
    }
    var scaleAnchor: UnitPoint {
        switch menuAlignment {
        case .bottomLeading: .bottomLeading
        case .bottom: .bottom
        case .bottomTrailing: .bottomTrailing
        case .topLeading: .topTrailing
        case .top: .top
        case .topTrailing: .topLeading
        case .leading: .leading
        case .trailing: .trailing
        default: .center
        }
    }
}

