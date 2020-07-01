  
// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "GeoJSONMap",
    platforms: [
        .macOS(.v10_10), .iOS(.v8), .tvOS(.v9), .watchOS(.v3)
    ],
    products: [
        .library(
            name: "GeoJSONMap",
            targets: ["GeoJSONMap"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "GeoJSONMap",
            dependencies: [],
            path: "Sources"),
//        .testTarget(
//            name: "GeoJSONMapTests",
//            dependencies: ["GeoJSONMap"],
//            path: "Tests"
//        )
    ]
)
