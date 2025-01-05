import Foundation
import SwiftUI

public enum PresentationType {
    case sheet
    case fullScreenCover
}

enum PresentationError: LocalizedError {
    case nonUniqueViewManager
    
    var errorDescription: String? {
        switch self {
        case .nonUniqueViewManager:
            "Presenting requires a unique viewManager"
        }
    }
}

public struct Page: Hashable {
    public static func == (lhs: Page, rhs: Page) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public let id: String
    public let view: AnyView
    public let navigationManager: NavigationManager?
    
    public init(id: String = UUID().uuidString, view: AnyView, navigationManager: NavigationManager? = nil) {
        self.id = id
        self.view = view
        self.navigationManager = navigationManager
    }
}
