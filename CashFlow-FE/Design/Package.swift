// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Design",
    defaultLocalization: "en",
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
        // No external package dependencies for Views target itself based on original Modules/Package.swift
        // If any are discovered later, they can be added here.
        // It will depend on Shared if any of its views use DTOs directly,
        // but that dependency would be at the target level.
        // For now, assuming no direct package dependencies for DesignPackage itself.
    ],
    targets: [
        .target(
            name: "Views",
            dependencies: [
                // If Views needs access to DTOs from Shared, that would be added here.
                // e.g. .product(name: "Shared", package: "Shared") if Shared was a separate package dependency
                // or .target(name: "Shared") if it was a target in this package (which it is not).
                // For now, assuming no direct dependencies for the target based on original.
                // This might need adjustment if compilation errors appear later.
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
