// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FeaturesPackage",
    defaultLocalization: "en",
    platforms: [
        .macOS(.v15), .iOS(.v17)
    ],
    products: [
        .library(name: "Features", targets: [
            "Home", "Product", "Transaction", "Settings"
        ]),
        .library(name: "Home", targets: ["Home"]),
        .library(name: "Transaction", targets: ["Transaction"]),
        .library(name: "Product", targets: ["Product"]),
        .library(name: "Settings", targets: ["Settings"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/mecid/swift-unidirectional-flow",
            .upToNextMajor(from: "0.4.0")
        ),
        .package(
            url: "https://github.com/hmlongco/Navigator",
            .upToNextMajor(from: "0.9.9")
        ),
        .package(path: "../Core"),
        .package(path: "../Design"),
    ],
    targets: [
        .target(
            name: "Home",
            dependencies: [
                .product(name: "Container", package: "Core"),
                .product(name: "Networking", package: "Core"),
                .product(name: "Router", package: "Core"),
                .product(name: "Views", package: "Design"),
                .product(name: "Navigator", package: "Navigator")
            ],
            path: "Sources/Home"
        ),
        .target(
            name: "Product",
            dependencies: [
                .product(name: "Container", package: "Core"),
                .product(name: "Networking", package: "Core"),
                .product(name: "Router", package: "Core"),
                .product(name: "Views", package: "Design"),
                .product(name: "Navigator", package: "Navigator")
            ],
            path: "Sources/Product"
        ),
        .target(
            name: "Transaction",
            dependencies: [
                .product(name: "Container", package: "Core"),
                .product(name: "Networking", package: "Core"),
                .product(name: "Router", package: "Core"),
                .product(name: "Views", package: "Design"),
                .product(name: "Navigator", package: "Navigator"),
                .product(name: "UnidirectionalFlow", package: "swift-unidirectional-flow")
            ],
            path: "Sources/Transaction"
        ),
        .target(
            name: "Settings",
            dependencies: [
                .product(name: "Container", package: "Core"),
                .product(name: "Networking", package: "Core"),
                .product(name: "Router", package: "Core"),
                .product(name: "Views", package: "Design"),
                .product(name: "Navigator", package: "Navigator"),
                .product(name: "UnidirectionalFlow", package: "swift-unidirectional-flow")
            ],
            path: "Sources/Settings"
        ),
    ]
)
