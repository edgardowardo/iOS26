import SwiftUI

struct MenuGlassContentView: View {
    @ObservedObject private var viewModel: WorkoutViewModel = .init()
    var body: some View {
        List {
            Section("Preview") {
                ZStack {
                }
                .frame(maxWidth: .infinity)
                .frame(height: 150)
                .background {
                    Image(.background)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                .clipShape(.rect(cornerRadius: 25))
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

