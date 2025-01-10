import SwiftUI

public struct FictionalNavigator<Content: View>: View, Identifiable {
    public let id = UUID()
    @ObservedObject var navigationManager: NavigationManager
    let rootView: () -> Content
    
    public init(navigationManager: NavigationManager, rootView: @escaping () -> Content) {
        self.navigationManager = navigationManager
        self.rootView = rootView
    }

    public var body: some View {
        NavigationStack(path: $navigationManager.navigator) {
            rootView()
            .navigationDestination(for: Page.self) { $0.view }
            .sheet(isPresented: $navigationManager.presentSheet, onDismiss: { navigationManager.dismiss(id: navigationManager.sheetID) }, content: {
                navigationManager.sheet
            })
            .fullScreenCover(isPresented: $navigationManager.presentFullSheet, onDismiss: { navigationManager.dismiss(id: navigationManager.fullScreenCoverID) }, content: {
                navigationManager.fullSheet
            })
        }
    }
}
