// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Design",
    platforms: [
        .macOS(.v15), .iOS(.v17)
    ],
    products: [
        .library(
            name: "Design",
            targets: ["Views", "Modifiers", "Resources"]),
        .library(
            name: "Views",
            targets: ["Views"]),
        .library(
            name: "Modifiers",
            targets: ["Modifiers"]),
        .library(
            name: "Resources",
            targets: ["Resources"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Views",
            dependencies: [
            ],
            path: "Sources/Views"
        ),
        .target(
            name: "Modifiers",
            dependencies: [],
            path: "Sources/Modifiers"
        ),
        .target(
            name: "Resources",
            dependencies: [],
            path: "Sources/Resources"
        )
    ]
)
