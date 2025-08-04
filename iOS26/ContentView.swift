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
                        labelProgressPadding: -35.0
                    ) {

//                        ForEach(RestTimeSeconds.allCases, id: \.self) { value in
//                            Text(value.description)
//                        }
                        
                        Text("Finish")
                            .onTapGesture {
                                withAnimation(.bouncy(duration: 1, extraBounce: 0.1)) {
                                    viewModel.finishWorkout()
                                }
                            }
//                            .containerValue(\.tintColor, .green.opacity(progress))
                            .containerValue(\.contentPadding, -25)
                        

                        Text("0:02")
                            .containerValue(\.contentPadding, -25)

//                        Image(systemName: "suit.heart.fill")
//                            .containerValue(\.unionID, "0")
//                            .containerValue(\.contentPadding, -7.5)
//                        Image(systemName: "square.and.arrow.up.fill")
//                        Image(systemName: "timer")
//                            .containerValue(\.contentPadding, -7.5)
//                            .containerValue(\.unionID, "0")
//                            .containerValue(\.contentPadding, -7.5)

                    } label: {
                        ZStack {
                            Label("Start", systemImage: "play.fill")
                                .onTapGesture {
                                    withAnimation(.bouncy(duration: 1, extraBounce: 0.1)) {
                                        viewModel.startWorkout()
                                    }
                                }
                                .opacity(1 - viewModel.progress)

                            Image(systemName: "timer")
                                .onTapGesture {
                                    withAnimation(.bouncy(duration: 1, extraBounce: 0.1)) {
                                        viewModel.pickRestTime()
                                    }
                                }
                                .opacity(viewModel.progress)
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
