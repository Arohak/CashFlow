// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Utils",
    defaultLocalization: "en",
    platforms: [
        .macOS(.v15), .iOS(.v17)
    ],
    products: [
        .library(
            name: "Utils",
            targets: ["Extensions", "Helpers"]),
        .library(
            name: "Extensions",
            targets: ["Extensions"]),
        .library(
            name: "Helpers",
            targets: ["Helpers"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Extensions",
            dependencies: [],
            path: "Sources/Extensions"
        ),
        .target(
            name: "Helpers",
            dependencies: [],
            path: "Sources/Helpers"
        )
    ]
)
