// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "SwiftcordIPC",
    products: [
        .library(
            name: "SwiftcordIPC",
            targets: ["SwiftcordIPC"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.0.0"),
    ],
    targets: [
        .target(
            name: "SwiftcordIPC",
            dependencies: [
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio"),
                .product(name: "NIOHTTP1", package: "swift-nio"),
            ]
        ),
        .testTarget(
            name: "SwiftcordIPCTests",
            dependencies: ["SwiftcordIPC"]
        ),
    ]
)
