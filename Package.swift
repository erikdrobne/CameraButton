// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "CameraButton",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "CameraButton", targets: ["CameraButton"])
    ],
    targets: [
        .target(name: "CameraButton", dependencies: [], path: "Sources"),
        .testTarget(name: "CameraButtonTests", dependencies: ["CameraButton"])
    ]
)
