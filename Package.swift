// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Spider",
    products: [
        .library(name: "Spider", targets: ["Spider"])
    ],
    dependencies: [],
    targets: [
        .target(name: "Spider", dependencies: []),
        .testTarget(name: "SpiderTests", dependencies: ["Spider"])
    ]
)
