// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "ExamplePackage",
    products: [
        .library(
            name: "ExamplePackage",
            targets: ["ExamplePackage"]),
    ],
    dependencies: [
        // libraries
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", exact: "1.11.1"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk", exact: "10.6.0"),
        
        // plugins
        .package(name: "LicensesPlugin", path: "../.."),
        .package(url: "https://github.com/SwiftGen/SwiftGenPlugin", exact: "6.6.2"),
    ],
    targets: [
        .target(
            name: "ExamplePackage",
            dependencies: [],
            plugins: [.plugin(name: "LicensesPlugin", package: "LicensesPlugin")]
        ),
        .testTarget(
            name: "ExamplePackageTests",
            dependencies: ["ExamplePackage"]),
    ]
)
