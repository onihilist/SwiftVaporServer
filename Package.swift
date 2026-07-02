// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftCLI",
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.76.0"),
        .package(url: "https://github.com/orlandos-nl/MongoKitten.git", from: "7.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "SwiftCLI",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "MongoKitten", package: "MongoKitten")
            ]
        ),
        .testTarget(
            name: "SwiftCLITests",
            dependencies: ["SwiftCLI"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
