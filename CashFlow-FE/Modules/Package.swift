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
        .library(name: "Feature", targets: [
            "Home", "Detail"
        ]),
        .library(name: "Home", targets: ["Home"]),
        .library(name: "Detail", targets: ["Detail"]),
        
        // MARK: - Foundation
        .library(name: "Foundation", targets: [
            "Models", "Networking", "Navigator"
        ]),
        .library(name: "Models", targets: ["Models"]),
        .library(name: "Navigator", targets: ["Navigator"]),
        .library(name: "Networking", targets: ["Networking"]),

        // MARK: - UI
        .library(name: "UI", targets: [
            "Views"
        ]),
//        .library(name: "Resources", targets: ["Resources"]),
        .library(name: "Views", targets: ["Views"]),
        
        // MARK: - Utility
        .library(name: "Utility", targets: [
            "Extensions"
        ]),
        .library(name: "Extensions", targets: ["Extensions"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/onevcat/Kingfisher",
            .upToNextMajor(from: "7.9.1")
        ),
        // Shared Models
        .package(path: "../Shared"),
    ],
    targets: [
        // MARK: - Feature
        .target(
            name: "Home",
            dependencies: [
                // Foundation
                .target(name: "Models"),
                .target(name: "Networking"),
                .target(name: "Navigator"),

                // Utility
                .target(name: "Extensions"),
                
                // UI
//                .target(name: "Resources"),
                .target(name: "Views")
            ],
            path: "Sources/Feature/Home"
//            resources: [.process("Resources/Process")]
        ),
        .target(
            name: "Detail",
            dependencies: [
                // Foundation
                .target(name: "Models"),
                .target(name: "Networking"),
                .target(name: "Navigator"),
                
                // Utility
                .target(name: "Extensions"),
                
                // UI
//                .target(name: "Resources"),
                .target(name: "Views")
                
                // Third Party
//                .byName(name: "Kingfisher")
            ],
            path: "Sources/Feature/Detail"
//            resources: [.process("Resources/Process")]
        ),
        
        // MARK: - Utility
        .target(
            name: "Extensions",
            path: "Sources/Utility/Extensions"
        ),
        
        // MARK: - Foundation
        .target(
            name: "Models",
            dependencies: [
                "Shared",
            ],
            path: "Sources/Foundation/Models"
        ),
        .target(
            name: "Networking",
            dependencies: [
                .target(name: "Models")
            ],
            path: "Sources/Foundation/Networking"
        ),
        .target(
            name: "Navigator",
            path: "Sources/Foundation/Navigator"
        ),

        // MARK: - UI
//        .target(
//            name: "Resources",
//            path: "Sources/UI/Resources",
//            resources: [.process("Process")]
//        ),
        .target(
            name: "Views",
//            dependencies: [
//                .target(name: "Resources")
//            ],
            path: "Sources/UI/Views"
        )
    ]
)
