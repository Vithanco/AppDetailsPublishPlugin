// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppDetailsPublishPlugin",
	platforms: [
		.macOS(.v12),
	],
    products: [
        .library(
            name: "AppDetailsPublishPlugin",
            targets: ["AppDetailsPublishPlugin"]),
    ],
    dependencies: [
		.package(url: "https://github.com/Vithanco/publish.git", from: "0.9.0")
    ],
    targets: [
        .target(
            name: "AppDetailsPublishPlugin",
			dependencies: [
				.product(name: "Publish", package: "publish")
			]),
        .testTarget(
            name: "AppDetailsPublishPluginTests",
            dependencies: ["AppDetailsPublishPlugin"]),
    ]
)
