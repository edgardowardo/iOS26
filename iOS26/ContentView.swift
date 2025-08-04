import SwiftUI

struct ContentView: View {
    @State private var progress: CGFloat = 0
    var body: some View {
        List {
            Section("Preview") {
                ZStack {
                    ExpandableHorizontalGlassContainer(
                        placeAtLeading: false,
                        size: .init(width: 130, height: 55),
                        progress: progress,
                        labelProgressPadding: -35.0
                    ) {

//                        ForEach(RestTimeSeconds.allCases, id: \.self) { value in
//                            Text(value.description)
//                        }
                        
                        Text("Finish")
                            .onTapGesture {
                                withAnimation(.bouncy(duration: 1, extraBounce: 0.1)) {
                                    progress = 0
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
//                            Text("Edit")
//                            Image(systemName: "ellipsis")
                            Label("Start", systemImage: "play.fill")
                                .onTapGesture {
                                    withAnimation(.bouncy(duration: 1, extraBounce: 0.1)) {
                                        progress = 1
                                    }
                                }
                                .opacity(1 - progress)
//                            Text("Done")
//                            Image(systemName: "xmark")
                            Image(systemName: "timer")
                                .opacity(progress)
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
                Slider (value: $progress)
                
                Button("Toggle Actions") {
                    withAnimation(.bouncy(duration: 1, extraBounce: 0.1)) {
                        progress = progress == 0 ? 1 : 0
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
