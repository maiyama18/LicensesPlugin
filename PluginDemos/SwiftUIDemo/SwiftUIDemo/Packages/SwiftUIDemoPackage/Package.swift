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
        .package(url: "https://github.com/sindresorhus/Defaults", exact: "8.2.0"),
        .package(url: "https://github.com/omaralbeik/Drops", exact: "1.7.0"),
        .package(url: "https://github.com/kean/Nuke", exact: "12.7.2"),
        
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
