// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "swift-posix",
    dependencies: [
        .package(url: "https://github.com/apple/swift-system", from: "1.0.0")
    ],
    targets: [
        .executableTarget(
            name: "cat",
            dependencies: [
                .product(name: "SystemPackage", package: "swift-system")
            ]),
        .testTarget(
            name: "catTests",
            dependencies: ["cat"]),
    ]
)
