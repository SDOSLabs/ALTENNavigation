// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ALTENNavigation",
    platforms: [
            .iOS(.v13)
    ],
    products: [
        .library(
            name: "ALTENNavigation",
            targets: ["ALTENNavigation"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "ALTENNavigation",
            dependencies: []),
        .testTarget(
            name: "ALTENNavigationTests",
            dependencies: ["ALTENNavigation"]),
    ]
)
