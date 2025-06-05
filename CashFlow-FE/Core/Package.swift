// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    defaultLocalization: "en",
    platforms: [
        .macOS(.v15), .iOS(.v17)
    ],
    products: [
        .library(
            name: "Core",
            targets: ["Container", "Networking", "Router", "Service"]),
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
            name: "Service",
            targets: ["Service"]),
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
        .target(
            name: "Service",
            path: "Sources/Service"
        ),
    ]
)
