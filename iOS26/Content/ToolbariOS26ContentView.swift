import SwiftUI

struct ToolbariOS26ContentView: View {
    @Namespace private var animation
    @State private var showMenu: Bool = false
    @State private var showShareOptions: Bool = false

    var body: some View {
        NavigationStack {
            List {
                
            }
            .navigationTitle("My Expenses")
            .navigationSubtitle("Aug 1 - Aug 31 (Last Month)")
            .toolbar {
                //
                // top bar
                //
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Notifications", systemImage: "bell") {
                        
                    }
                }
                // .sharedBackgroundVisibility(.hidden)
                
                ToolbarSpacer(.flexible, placement: .topBarTrailing)
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Account", systemImage: "person") {
                        showMenu.toggle()
                    }
                }
                .matchedTransitionSource(id: "Account", in: animation)

                //
                // bottom bar
                //
                ToolbarItem(placement: .bottomBar) {
                    Button("Share", systemImage: "square.and.arrow.up") {
                        showShareOptions.toggle()
                    }
                }
                .matchedTransitionSource(id: "Share", in: animation)


                ToolbarItem(placement: .bottomBar) {
                    Button("Clipboard", systemImage: "paperclip") {
                        
                    }
                }
                
                ToolbarSpacer(.flexible, placement: .bottomBar)

                ToolbarItem(placement: .bottomBar) {
                    Button("Write", systemImage: "square.and.pencil") {
                        
                    }
                }
            }
            .sheet(isPresented: $showMenu) {
                Text("Account Sheet")
                    .font(Font.largeTitle.bold())
                    .navigationTransition(.zoom(sourceID: "Account", in: animation))
            }
            .sheet(isPresented: $showShareOptions) {
                Text("Share Options")
                    .font(Font.largeTitle.bold())
                    .navigationTransition(.zoom(sourceID: "Share", in: animation))
                    .presentationDetents([.height(350)])
            }

        }
    }
}

