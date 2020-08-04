# Relevant Informer

Relevant Informer is zero-dependency popup / message / notification library.

## RI 101
```swift
let view = MyViewController()
view.ri.display(with: RIAttributes.popup)
```

## Features
- [x] Display modes: enqueue and override.
- [ ] SwiftUI support.
- [ ] Carthage and CocoaPods support.

## Installation
### Swift Package Manager
```swift
dependencies: [
    .package(url: "https://github.com/relevantfruit/RelevantInformer", .upToNextMajor(from: "0.4.0"))
]
```

## Requirements
- iOS 12.0+
- Xcode 11+
- Swift 5.1+
