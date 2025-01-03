// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Shared",
    platforms: [
        .macOS(.v15), .iOS(.v17)
    ],
    products: [
        .library(
            name: "Shared",
            targets: ["Shared"]),
    ],
    targets: [
        .target(
            name: "Shared"),

    ]
)
