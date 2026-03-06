// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DocIDVAI",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "DocIDVAI",
            targets: ["DocIDVAI-Target-Wrapper"]
        ),
        .library(
            name: "DocIDVAI-with-XS2A",
            targets: ["DocIDVAI-with-XS2A-Target-Wrapper"]
        )
    ],
    // Define external dependencies (via SPM).
    dependencies: [
        .package(url: "https://github.com/idnow/sunflower-sdk-ios.git", exact: "2.1.4"),
        .package(url: "https://github.com/unissey/sdk-ios.git", exact: "4.0.0"),
    ],
    targets: [
        // Define our 2 SDK internal binaries and their location.
        .binaryTarget(
            name: "DocIDVAI",
            url: "https://github.com/nabil-lahlou-idnow/docidv-ai-test/releases/download/1.6.1/DocIDVAI.xcframework.zip",
            checksum: "5d91076cd414d5097ba25428aa54ff20cebf2e1d1440ae4b7fcb885bb1eb66eb"
        ),
        .binaryTarget(
            name: "DocIDVAI-with-XS2A",
            url: "https://github.com/nabil-lahlou-idnow/docidv-ai-test/releases/download/1.6.1/DocIDVAI-with-XS2A.xcframework.zip",
            checksum: "94fd84a01f7ec3ca2b062e0e78e0c2d1d108b8b3ed94b6b6528c16459c997727"
        ),
        // Define the third parties dependencies imported locally.
        .binaryTarget(
            name: "FaceTecSDK",
            path: "Frameworks/FaceTecSDK.xcframework"
        ),
        .binaryTarget(
            name: "ReadID_UI",
            path: "Frameworks/ReadID_UI.xcframework"
        ),
        // Define a wrapper which will encapsulate every dependencies in it.
        .target(
            name: "DocIDVAI-Target-Wrapper",
            dependencies: [
                // Local DocIDVAI sdk binaries.
                "DocIDVAI",
                // External frameworks saved locally.
                "FaceTecSDK",
                "ReadID_UI",
                // External public frameworks.
                .product(name: "UnisseySdk", package: "sdk-ios"),
                .product(name: "SunflowerUIKit", package: "sunflower-sdk-ios")
            ],
            path: "sources/DocIDVAI" // Path to an empty .swift file, needed by SPM.
        ),
        // Define a wrapper for 2nd target with XS2A library.
        .target(
            name: "DocIDVAI-with-XS2A-Target-Wrapper",
            dependencies: [
                // Local DocIDVAI sdk binaries (with XS2A lib).
                "DocIDVAI-with-XS2A",
                // External frameworks saved locally.
                "FaceTecSDK",
                "ReadID_UI",
                // External public frameworks.
                .product(name: "UnisseySdk", package: "sdk-ios"),
                .product(name: "SunflowerUIKit", package: "sunflower-sdk-ios")
            ],
            path: "sources/DocIDVAI-with-XS2A" // Path to another empty .swift file, needed by SPM.
        )
    ]
)
