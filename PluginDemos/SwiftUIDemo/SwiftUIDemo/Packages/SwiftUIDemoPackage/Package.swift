// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "SwiftUIDemoPackage",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        .library(
            name: "SwiftUIDemoPackage",
            targets: ["SwiftUIDemoPackage"]),
    ],
    dependencies: [
        .package(url: "https://github.com/sindresorhus/Defaults", exact: "7.1.0"),
        .package(url: "https://github.com/omaralbeik/Drops", exact: "1.6.1"),
        .package(url: "https://github.com/kean/Nuke", exact: "12.0.0"),
        
        // LicensesPlugin
        .package(path: "../../../../.."),
    ],
    targets: [
        .target(
            name: "SwiftUIDemoPackage",
            dependencies: [],
            plugins: [.plugin(name: "LicensesPlugin", package: "LicensesPlugin")]
        ),
    ]
)
