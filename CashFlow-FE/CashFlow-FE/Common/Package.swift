// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Common",
    platforms: [
        .macOS(.v15), .iOS(.v17)
    ],
    products: [
        .library(
            name: "Common",
            targets: ["Container", "Networking", "Router", "Helper", "Extension"]),
        .library(
            name: "Container",
            targets: ["Container"]),
        .library(
            name: "Networking",
            targets: ["Networking"]),
        .library(
            name: "Router",
            targets: ["Router"]),
        .library(
            name: "Helper",
            targets: ["Helper"]),
        .library(
            name: "Extension",
            targets: ["Extension"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/hmlongco/Factory",
            .upToNextMajor(from: "2.4.3")
        ),
        .package(path: "../../Shared"),
    ],
    targets: [
        .target(
            name: "Container",
            dependencies: [
                "Shared",
                "Networking",
                .product(name: "Factory", package: "Factory")
            ],
            path: "Sources/Container"
        ),
        .target(
            name: "Networking",
            dependencies: [
                "Shared"
            ],
            path: "Sources/Networking"
        ),
        .target(
            name: "Router",
            path: "Sources/Router"
        ),
        .target(name: "Helper"),
        .target(name: "Extension"),
    ]
)
