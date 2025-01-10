import SwiftUI
import Combine

public class NavigationManager: ObservableObject, Identifiable {
    @Published private var paths = [NavigationManager]()
    @Published internal var navigator = [Page]()
    internal var sheetID: String = ""
    @Published internal var presentSheet = false
    @Published internal var sheet: AnyView?
    internal var fullScreenCoverID: String = ""
    @Published internal var presentFullSheet = false
    @Published internal var fullSheet: AnyView?
    
    public init() {}
    
    public func push(id: String, view: AnyView) {
        if paths.count > 0 {
            paths.last?.navigator.append(Page(id: id, view: view))
        } else {
            self.navigator.append(Page(id: id, view: view))
        }
    }
    
    public func presentSheet(id: String, view: AnyView) {
        if paths.count > 0 {
            self.paths.append(NavigationManager())
            paths[paths.count - 2].sheetID = id
            paths[paths.count - 2].presentSheet = true
            paths[paths.count - 2].sheet = AnyView(FictionalNavigator(navigationManager: paths.last!) { view })
        } else {
            self.paths.append(NavigationManager())
            self.sheetID = id
            self.presentSheet = true
            self.sheet = AnyView(FictionalNavigator(navigationManager: paths.last!) { view })
        }
    }
    
    public func presentFullScreenCover(id: String, view: AnyView) {
        if paths.count > 0 {
            self.paths.append(NavigationManager())
            paths[paths.count - 2].fullScreenCoverID = id
            paths[paths.count - 2].presentFullSheet = true
            paths[paths.count - 2].fullSheet = AnyView(FictionalNavigator(navigationManager: paths.last!) { view })
        } else {
            self.paths.append(NavigationManager())
            self.fullScreenCoverID = id
            self.presentFullSheet = true
            self.fullSheet = AnyView(FictionalNavigator(navigationManager: paths.last!) { view })
        }
    }
    
    public func dismiss(id: String) {
        if sheetID == id {
            self.presentSheet = false
            self.sheet = nil
            if paths.count > 0 {
                self.paths.removeSubrange(0...(paths.count - 1))
            }
        } else if fullScreenCoverID == id {
            self.presentFullSheet = false
            self.fullSheet = nil
            if paths.count > 0 {
                self.paths.removeSubrange(0...(paths.count - 1))
            }
        } else {
            self.navigator.removeAll { $0.id == id }
        }
        
        if let idOfViewManager = paths.firstIndex(where: { $0.sheetID == id }) {
            self.paths[idOfViewManager].presentSheet = false
            self.paths[idOfViewManager].sheet = nil
            self.paths.removeSubrange(idOfViewManager...(paths.count - 1))
        } else if let idOfViewManager = paths.firstIndex(where: { $0.fullScreenCoverID == id }) {
            self.paths[idOfViewManager].presentFullSheet = false
            self.paths[idOfViewManager].fullSheet = nil
            self.paths.removeSubrange(idOfViewManager...(paths.count - 1))
        } else if let idOfViewManager = paths.firstIndex(where: {
            $0.navigator.contains { element in
                element.id == id
            }
        }) {
            self.paths[idOfViewManager].navigator.removeAll { $0.id == id }
        }
    }
}
