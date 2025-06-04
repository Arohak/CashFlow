// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CorePackage",
    defaultLocalization: "en",
    platforms: [
        .macOS(.v15), .iOS(.v17)
    ],
    products: [
        .library(
            name: "Core",
            targets: ["Container", "Networking", "MyNavigator"]),
        .library(
            name: "Container",
            targets: ["Container"]),
        .library(
            name: "Networking",
            targets: ["Networking"]),
        .library(
            name: "MyNavigator",
            targets: ["MyNavigator"]),
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
            name: "MyNavigator",
            path: "Sources/MyNavigator"
        ),
    ]
)
