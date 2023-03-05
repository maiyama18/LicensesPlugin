// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "LicensesPlugin",
    products: [
        .plugin(
            name: "LicensesPlugin",
            targets: ["LicensesPlugin"]),
    ],
    dependencies: [],
    targets: [
        .plugin(
            name: "LicensesPlugin",
            capability: .buildTool()
        ),
    ]
)
