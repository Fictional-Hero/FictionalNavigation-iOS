import SwiftUI
import Combine

public class NavigationManager: ObservableObject, Identifiable {
    private var updateFromArray = false
    private var fromPaths = false
    @Published internal var navigator = [Page]()
    @Published internal var presentSheet = false
    @Published internal var sheet: AnyView?
    @Published internal var presentFullSheet = false
    @Published internal var fullSheet: AnyView?
    
    public init() {}
    
    public func push(id: String, view: AnyView) {
        self.navigator.append(Page(id: id, view: view))
    }
    
    public func present(view: AnyView, navigationManager: NavigationManager, presentationStyle: PresentationType) throws {
        if navigationManager.id == self.id {
            print("‼️ Presented views require a unique viewManager")
            throw PresentationError.nonUniqueViewManager
        }
        switch presentationStyle {
        case .sheet:
            self.presentSheet = true
            self.sheet = AnyView(FictionalNavigator(navigationManager: navigationManager) { view })
        case .fullScreenCover:
            self.presentFullSheet = true
            self.fullSheet = AnyView(FictionalNavigator(navigationManager: navigationManager) { view })
        }
    }
    
    public func dismiss(id: String) {
        self.navigator.removeAll { $0.id == id }
    }
    
    public func dismiss(presentation: PresentationType) {
        switch presentation {
        case .sheet:
            self.presentSheet = false
            self.sheet = nil
        case .fullScreenCover:
            self.presentFullSheet = false
            self.fullSheet = nil
        }
    }
}
