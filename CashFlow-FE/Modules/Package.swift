// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    defaultLocalization: "en",
    platforms: [
        .macOS(.v15), .iOS(.v17)
    ],
    products: [
        // MARK: - Feature
        .library(name: "Features", targets: [
            "Home", "Product", "Transaction", "Settings"
        ]),
        .library(name: "Home", targets: ["Home"]),
        .library(name: "Transaction", targets: ["Transaction"]),
        .library(name: "Product", targets: ["Product"]),
        .library(name: "Settings", targets: ["Settings"]),

        // MARK: - Core
        .library(name: "Core", targets: [
            "Container", "Networking", "MyNavigator"
        ]),
        .library(name: "Container", targets: ["Container"]),
        .library(name: "MyNavigator", targets: ["MyNavigator"]),
        .library(name: "Networking", targets: ["Networking"]),

        // MARK: - Design
        .library(name: "Design", targets: [
            "Views"
        ]),
//        .library(name: "Resources", targets: ["Resources"]),
        .library(name: "Views", targets: ["Views"]),
    ],
    dependencies: [
//        .package(
//            url: "https://github.com/onevcat/Kingfisher",
//            .upToNextMajor(from: "8.1.3")
//        ),
        .package(
            url: "https://github.com/mecid/swift-unidirectional-flow",
            .upToNextMajor(from: "0.4.0")
        ),
        .package(
            url: "https://github.com/hmlongco/Factory",
            .upToNextMajor(from: "2.4.3")
        ),
        .package(
            url: "https://github.com/hmlongco/Navigator",
            .upToNextMajor(from: "0.9.9")
        ),

        .package(path: "../Shared"),
    ],
    targets: [
        // MARK: - Features
        .target(
            name: "Home",
            dependencies: [
                // Core
                .target(name: "Container"),
                .target(name: "Networking"),
                .target(name: "MyNavigator"),
                
                // Design
//                .target(name: "Resources"),
                .target(name: "Views"),
                
                // Third Party
                .product(name: "Navigator", package: "navigator")
            ],
            path: "Sources/Features/Home"
//            resources: [.process("Resources/Process")]
        ),
        .target(
            name: "Product",
            dependencies: [
                // Core
                .target(name: "Container"),
                .target(name: "Networking"),
                .target(name: "MyNavigator"),

                // Design
//                .target(name: "Resources"),
                .target(name: "Views"),
                
                // Third Party
                .product(name: "Navigator", package: "navigator")
            ],
            path: "Sources/Features/Product"
//            resources: [.process("Resources/Process")]
        ),
        .target(
            name: "Transaction",
            dependencies: [
                // Core
                .target(name: "Container"),
                .target(name: "Networking"),
                .target(name: "MyNavigator"),

                // Design
                .target(name: "Views"),
                
                // Third Party
                .product(name: "Navigator", package: "navigator"),
                .product(name: "UnidirectionalFlow", package: "swift-unidirectional-flow")
            ],
            path: "Sources/Features/Transaction"
        ),
        .target(
            name: "Settings",
            dependencies: [
                // Core
                .target(name: "Container"),
                .target(name: "Networking"),
                .target(name: "MyNavigator"),

                // Design
                .target(name: "Views"),
                
                // Third Party
                .product(name: "Navigator", package: "navigator"),
                .product(name: "UnidirectionalFlow", package: "swift-unidirectional-flow")
            ],
            path: "Sources/Features/Settings"
        ),
        
        // MARK: - Core
        .target(
            name: "Container",
            dependencies: [
                "Shared",
                "Networking",
                .product(name: "Factory", package: "factory")
            ],
            path: "Sources/Core/Container"
        ),
        .target(
            name: "Networking",
            dependencies: [
                "Shared"
            ],
            path: "Sources/Core/Networking"
        ),
        .target(
            name: "MyNavigator",
            path: "Sources/Core/MyNavigator"
        ),

        // MARK: - Design
//        .target(
//            name: "Resources",
//            path: "Sources/Design/Resources",
//            resources: [.process("Process")]
//        ),
        .target(
            name: "Views",
//            dependencies: [
//                .target(name: "Resources")
//            ],
            path: "Sources/Design/Views"
        )
    ]
)
