# SupportChatKit

SupportChatKit is a Swift Package that provides an easy-to-integrate support chat interface for your iOS app. It supports both UIKit and SwiftUI, and integrates seamlessly with Firebase for real-time messaging.

## Installation

Add SupportChatKit to your Xcode project using Swift Package Manager:

1. In Xcode, go to **File > Add Packages...**
2. Enter the package repository URL: `https://github.com/vishalvaghasiya-ios/SupportChatKit.git`
3. Select the latest version and add the package to your project.

## Setup

Before using SupportChatKit, make sure to configure Firebase in your app:

1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Add your iOS app to the Firebase project and download the `GoogleService-Info.plist` file.
3. Add the `GoogleService-Info.plist` file to your Xcode project.
4. Install Firebase dependencies via Swift Package Manager or CocoaPods.
5. Initialize Firebase in your `AppDelegate` or `@main` struct:

```swift
import Firebase

@main
struct YourApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

## Usage

### UIKit

To present the support chat interface in a UIKit-based app:

```swift
import SupportChatKit

let supportChatVC = SupportChatViewController()
navigationController?.pushViewController(supportChatVC, animated: true)
```

### SwiftUI

To use SupportChatKit in a SwiftUI app, embed the chat view as follows:

```swift
import SupportChatKit
import SwiftUI

struct ContentView: View {
    var body: some View {
        SupportChatView()
    }
}
```

## Firebase Configuration

SupportChatKit uses Firebase Firestore for storing and syncing messages. Ensure that your Firebase Firestore database rules allow authenticated users to read and write messages:

```json
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /supportChats/{chatId} {
      allow read, write: if request.auth != null;
    }
  }
}
```

Make sure your app handles user authentication or anonymous sign-in to use the chat features.

---

For more information or support, please refer to the project repository or contact the maintainer.
