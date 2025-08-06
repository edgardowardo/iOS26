import SwiftUI

struct MenuGlassContentView: View {
    @ObservedObject private var viewModel: WorkoutViewModel = .init()
    var body: some View {
        List {
            Section("Preview") {
                Rectangle()
                    .foregroundStyle(.clear)
                    .background {
                        Image(.background)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .contentShape(.rect)
                            .onTapGesture {
                                withAnimation(.bouncy(duration: 1, extraBounce: 0.1)) {
                                    viewModel.progress = 0
                                }
                            }
                    }
                    .overlay {
                        ExpandableGlassMenu(alignment: .bottom, progress: viewModel.progress) {
                            VStack(alignment: .leading, spacing: 12) {
                                RowView("paperplane", "Send")
                                RowView("arrow.trianglehead.2.counterclockwise", "Swap")
                                RowView("arrow.down", "Receive")
                            }
                            .padding(10)
                        } label: {
                            Image(systemName: "square.and.arrow.up.fill")
                                .font(.title3)
                                .frame(width: 55, height: 55)
                                .contentShape(.rect)
                                .onTapGesture {
                                    withAnimation(.bouncy(duration: 1, extraBounce: 0.1)) {
                                        viewModel.progress = 1
                                    }
                                }
                        }
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity,
                            alignment: .bottom
                        )
                        .padding(15)
                    }
                    .frame(height: 330)
                
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            Section("Properties") {
                Slider (value: $viewModel.progress)
                
                Button("Toggle Actions") {
                    withAnimation(.bouncy(duration: 1, extraBounce: 0.1)) {
                        viewModel.progress = viewModel.progress == 0 ? 1 : 0
                    }
                }
                .buttonStyle(.glassProminent)
                .frame(maxWidth: .infinity)
            }
        }
    }
    
    
    @ViewBuilder
    func RowView(_ image: String, _ title: String) -> some View {
        HStack(spacing: 18) {
            Image(systemName: image)
                .font(.title3)
                .symbolVariant(.fill)
                .frame(width: 45, height: 45)
                .background(.background, in: .circle)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .fontWeight(.semibold)
                Text("This is a sampe text ")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
        }
        .padding(10)
        .contentShape(.rect)
    }

}




struct ContentView: View {
    var body: some View {
//        HGlassContentView()
        MenuGlassContentView()
    }
}

#Preview {
    ContentView()
}

struct ExpandableGlassMenu<Content: View, Label: View>: View, Animatable {
    var alignment: Alignment
    var progress: CGFloat
    var labelSize: CGSize = .init(width: 55, height: 55)
    var cornerRadius: CGFloat = 30
    @ViewBuilder var content: Content
    @ViewBuilder var label: Label
    @State private var contentSize: CGSize = .zero
    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }

    var body: some View {
        GlassEffectContainer {
            let widthDiff = contentSize.width - labelSize.width
            let heightDiff = contentSize.height - labelSize.height
            let rWidth = widthDiff * contentOpacity
            let rHeight = heightDiff * contentOpacity
            
            ZStack(alignment: alignment) {
                content
                    .compositingGroup()
                    .scaleEffect(contentScale)
                    .blur(radius: 14 * blurProgress)
                    .opacity(contentOpacity)
                    .onGeometryChange(for: CGSize.self) {
                        $0.size
                    } action: { newValue in
                        contentSize = newValue
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
    
    var labelOpacity: CGFloat { min(progress / 0.35, 1) }
    var contentOpacity: CGFloat { max(progress - 0.35, 0) / 0.65 }
    var contentScale: CGFloat {
        let minAspectScale = min(labelSize.width / contentSize.width, labelSize.height / contentSize.height)
        return minAspectScale + (1 - minAspectScale) * progress
    }
    var blurProgress: CGFloat { progress > 0.5 ? (1 - progress) / 0.5 : progress / 0.5 }
    var offset: CGFloat {
        switch alignment {
        case .bottom, .bottomLeading, .bottomTrailing: -75
        case .top, .topLeading, .topTrailing: 75
        default: 0
        }
    }
    var scaleAnchor: UnitPoint {
        switch alignment {
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
