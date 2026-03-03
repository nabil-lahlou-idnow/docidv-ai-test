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
            name: "DocIDVAI-without-XS2A",
            targets: ["DocIDVAI-without-XS2A-Target-Wrapper"]
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
            url: "https://github.com/nabil-lahlou-idnow/docidv-ai-test/releases/download/1.4.0/DocIDVAI.xcframework.zip",
            checksum: "513047fd2ac6c0aeeee41dbe53ead57f2c1049a99fc25c5022b08926ba6ebc2d"
        ),
        .binaryTarget(
            name: "DocIDVAI-without-XS2A",
            url: "https://github.com/nabil-lahlou-idnow/docidv-ai-test/releases/download/1.4.0/DocIDVAI-without-XS2A.xcframework.zip",
            checksum: "2ddd09da6e1a94c352e7a78b81a9aaf168fc00cc0eaf6cca27760222270196ad"
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
        // Define a wrapper for 2nd target without XS2A library.
        .target(
            name: "DocIDVAI-without-XS2A-Target-Wrapper",
            dependencies: [
                // Local DocIDVAI sdk binaries (without XS2A lib).
                "DocIDVAI-without-XS2A",
                // External frameworks saved locally.
                "FaceTecSDK",
                "ReadID_UI",
                // External public frameworks.
                .product(name: "UnisseySdk", package: "sdk-ios"),
                .product(name: "SunflowerUIKit", package: "sunflower-sdk-ios")
            ],
            path: "sources/DocIDVAI-without-XS2A" // Path to another empty .swift file, needed by SPM.
        )
    ]
)
