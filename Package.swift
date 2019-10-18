// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "CommonExtensions",
    platforms: [
        .iOS(.v9),
        .macOS(.v10_13),
    ],
    products: [
        .library(
            name: "CommonExtensions",
            targets: ["CommonExtensions"]
        ),
    ],
    targets: [
        .target(
            name: "CommonExtensions",
            dependencies: [],
            path: "CommonExtensions/Classes"
        ),
    ]
)
