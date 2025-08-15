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
                        ExpandableGlassMenu(menuAlignment: .bottom, progress: viewModel.progress) {
                            numericKeyboardView
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
    
    var numericKeyboardView: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                ForEach(["1", "2", "3"], id: \.self) { num in
                    Button(action: { /* handle number tap */ }) {
                        Text(num)
                            .frame(width: 55, height: 55)
                            .font(.title)
                            .background(.background, in: .circle)
                    }
                }
            }
            HStack(spacing: 12) {
                ForEach(["4", "5", "6"], id: \.self) { num in
                    Button(action: { /* handle number tap */ }) {
                        Text(num)
                            .frame(width: 55, height: 55)
                            .font(.title)
                            .background(.background, in: .circle)
                    }
                }
            }
            HStack(spacing: 12) {
                ForEach(["7", "8", "9"], id: \.self) { num in
                    Button(action: { /* handle number tap */ }) {
                        Text(num)
                            .frame(width: 55, height: 55)
                            .font(.title)
                            .background(.background, in: .circle)
                    }
                }
            }
            HStack(spacing: 12) {
                Button(action: { /* handle space tap */ }) {
                    Text("")
                        .frame(width: 55, height: 55)
                        .font(.title3)
                        .background(.clear, in: .circle)
                }
                Button(action: { /* handle zero tap */ }) {
                    Text("0")
                        .frame(width: 55, height: 55)
                        .font(.title)
                        .background(.background, in: .circle)
                }
                Button(action: { /* handle back tap */ }) {
                    Text("<")
                        .frame(width: 55, height: 55)
                        .font(.title)
                        .background(.background, in: .circle)
                }
            }
        }
        .foregroundColor(.primary)
        .padding(20)
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
