// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "RelevantInformer",
  platforms: [
    .iOS(.v12),
  ],
  products: [
    .library(
      name: "RelevantInformer",
      targets: ["RelevantInformer"]),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "RelevantInformer",
      dependencies: []),
    .testTarget(
      name: "RelevantInformerTests",
      dependencies: ["RelevantInformer"]),
  ]
)
