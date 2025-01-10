# FictionalNavigator Framework

The **FictionalNavigator** framework provides a SwiftUI-based navigation management solution for complex navigation flows. It allows developers to handle navigation stacks, modal presentations, and full-screen covers with a clean and reusable approach.

## Features
- **Dynamic NavigationStack Management**: Easily manage a stack of views using a shared navigation manager.
- **Sheet and Full-Screen Cover Presentations**: Present modals with flexible presentation styles.
- **Observable NavigationManager**: Centralized state management for navigation.
- **Reusable Components**: Supports unique navigation contexts for complex flows.

## Installation

### Swift Package Manager
To add FictionalNavigator to your project, use the following steps:

1. In Xcode, navigate to **File > Add Packages**.
2. Enter the repository URL: `https://github.com/Fictional-Hero/FictionalNavigation-iOS`
3. Select the latest version and add it to your project.

## Usage

### Basic Setup

1. Import the framework:
   ```swift
   import FictionalNavigator
   ```

2. Create a `NavigationManager` instance: 
   ```swift
   let navigationManager = NavigationManager()
   ```

3. Use `FictionalNavigator` to wrap any root views :
   ```swift
   struct ContentView: View {
       var body: some View {
           FictionalNavigator(navigationManager: navigationManager) {
               Text("Home")
           }
       }
   }
   ```

### Pushing a View onto the Stack
To push a new view:

```swift
navigationManager.push(id: "home", view: AnyView(Text("Home Screen")))
```

### Presenting a Modal
To present a view as a sheet or full-screen cover:

```swift
navigationManager.presentFullScreenCover(id: "Sheet-1", view: AnyView(Text("Presented Sheet")))
```

### Dismissing a View
- Dismiss a view:
  ```swift
  navigationManager.dismiss(id: "Sheet-1")
  ```
- Note that dismissing a sheet, or full screen cover will dismiss all children


## License
This project is licensed under the MIT License. See the LICENSE file for details.

