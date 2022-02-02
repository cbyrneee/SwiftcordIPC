# SwiftcordIPC
> A light-weight and easy to use Discord IPC library backed by [swift-nio](https://github.com/apple/swift-nio)

[![Swift Version][swift-image]][swift-url]
[![License][license-image]][license-url]

Swiftcord IPC is an easy to use Discord IPC library. 
Many other RPC / IPC libraries for Discord in Swift either don't work, or are very buggy. SwiftcordIPC is designed to be reliable and up-to-date.

**Note: At the moment, we have not found a way to use SwiftcordIPC inside the App Sandbox, however I am actively working on a solution for this.**

## Installation

Add this project to your `Package.swift`

```swift
import PackageDescription

let package = Package(
    dependencies: [
        .Package(url: "https://github.com/cbyrneee/SwiftcordIPC.git", from: "1.0.0")
    ]
)
```

## Usage example


```swift
import SwiftcordIPC

let ipc = SwiftcordIPC(id: "937029972139327558")
ipc.onReady = { data in
    print("Ready! User: \(data.user.username)#\(data.user.discriminator)")
    
    ipc.setPresence { data in
        data.details = "hello"
        data.state = "world"
        data.assets = assets(largeImage: "hello", largeImageText: "world")
        data.buttons = [
            button(label: "click me!", url: "https://cbyrne.dev")
        ]
    }
}

// An error will be thrown here if connection has failed, e.g. ConnectionError.noIpcFile
try ipc.connectAndBlock()
```

## Meta

Conor Byrne – [@cbyrnedev](https://twitter.com/cbyrnedev) – hello@cbyrne.dev

Distributed under the MIT license. See ``LICENSE`` for more information.

[swift-image]:https://img.shields.io/badge/swift-5.5-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
