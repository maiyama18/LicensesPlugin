// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "TrickyLicense",
    products: [
        .library(
            name: "TrickyLicense",
            targets: ["TrickyLicense"]),
    ],
    targets: [
        .target(
            name: "TrickyLicense"),
    ]
)
