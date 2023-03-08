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
        .package(path: "../../../../..")
    ],
    targets: [
        .target(
            name: "SwiftUIDemoPackage",
            dependencies: [],
            plugins: [.plugin(name: "LicensesPlugin", package: "LicensesPlugin")]
        ),
    ]
)
