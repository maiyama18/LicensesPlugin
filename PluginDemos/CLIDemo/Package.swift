// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "CLIDemo",
    dependencies: [
        // LicensesPlugin
        .package(path: "../.."),
    ],
    targets: [
        .executableTarget(
            name: "CLIDemo",
            path: "Sources",
            plugins: [.plugin(name: "LicensesPlugin", package: "LicensesPlugin")]
        ),
    ]
)
