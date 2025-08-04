import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel: WorkoutViewModel = .init()
    var body: some View {
        List {
            Section("Preview") {
                ZStack {
                    ExpandableHorizontalGlassContainer(
                        placeAtLeading: false,
                        size: .init(width: 130, height: 55),
                        progress: viewModel.progress,
                        state: viewModel.state,
                        labelProgressPadding: -35.0
                    ) {
                        if viewModel.state == .started {
                            Text("Finish")
                                .onTapGesture {
                                    withAnimation(.bouncy(duration: 1, extraBounce: 0.1)) {
                                        viewModel.finishWorkout()
                                    }
                                }
//                                .containerValue(\.tintColor, .green)
                                .containerValue(\.contentPadding, -20)
                            Text("0:02")
                                .containerValue(\.contentPadding, -20)
                        } else if viewModel.state == .picker {
                            ForEach(RestTimeSeconds.allCases, id: \.self) { value in
                                Text(value.description)
                                    .containerValue(\.contentPadding, -20)
                            }
                        }
                    } label: {
                        ZStack {
                            if viewModel.state == .initial {
                                Label("Start", systemImage: "play.fill")
                                    .onTapGesture {
                                        withAnimation(.bouncy(duration: 1, extraBounce: 0.1)) {
                                            viewModel.startWorkout()
                                        }
                                    }
                                    .opacity(1 - viewModel.progress)
                            } else if viewModel.state == .picker {
                                Image(systemName: "xmark")
                                    .onTapGesture {
                                        withAnimation(.bouncy(duration: 1, extraBounce: 0.1)) {
                                            viewModel.finishWorkout()
                                        }
                                    }
                                    .opacity(viewModel.progress)
                            } else if viewModel.state == .started {
                                Image(systemName: "timer")
                                    .onTapGesture {
                                        withAnimation(.bouncy(duration: 1, extraBounce: 0.1)) {
                                            viewModel.progress = 0
                                        }
                                        withAnimation(.bouncy(duration: 1, extraBounce: 0.1)) {
                                            viewModel.pickRestTime()
                                        }
                                    }
                                    .opacity(viewModel.progress)
                            }
                        }
                    }
                    .foregroundStyle(.primary)
                    .font(.title3)
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

#Preview {
    ContentView()
}
