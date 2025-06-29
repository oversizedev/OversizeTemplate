#!/bin/bash

mkdir Packages
cd Packages

# Create Database package
mkdir Database
cd Database
swift package init --type library
# Replace content of Package.swift for Database package
cat <<EOF >Package.swift
// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import Foundation
import PackageDescription

let remoteDependencies: [PackageDescription.Package.Dependency] = [
    .package(url: "https://github.com/oversizedev/OversizeCore.git", .upToNextMajor(from: "1.3.0")),
    .package(url: "https://github.com/nicklockwood/SwiftFormat", .upToNextMajor(from: "0.52.10")),
]

let localDependencies: [PackageDescription.Package.Dependency] = [
    .package(name: "OversizeCore", path: "../../../Packages/OversizeCore"),
    .package(url: "https://github.com/nicklockwood/SwiftFormat", .upToNextMajor(from: "0.52.10")),
]

let dependencies: [PackageDescription.Package.Dependency] = remoteDependencies

let package = Package(
    name: "Database",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
        .watchOS(.v10),
    ],
    products: [
        .library(
            name: "Database",
            targets: ["Database"]
        ),
    ],
    dependencies: dependencies,
    targets: [
        .target(
            name: "Database",
            dependencies: [
                .product(name: "OversizeCore", package: "OversizeCore"),
            ]
        ),
        .testTarget(
            name: "DatabaseTests",
            dependencies: ["Database"]
        ),
    ]
)
EOF

cd ..

# Create App package
mkdir App
cd App
swift package init --type library
# Replace content of Package.swift for Database package
cat <<EOF >Package.swift
// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import Foundation
import PackageDescription

let remoteDependencies: [PackageDescription.Package.Dependency] = [
    .package(name: "Database", path: "../Database"),
    .package(name: "Env", path: "../Env"),
    .package(url: "https://github.com/oversizedev/OversizeKit.git", .upToNextMajor(from: "2.0.0")),
    .package(url: "https://github.com/oversizedev/OversizeUI.git", .upToNextMajor(from: "3.0.2")),
    .package(url: "https://github.com/oversizedev/OversizeServices.git", .upToNextMajor(from: "1.4.0")),
    .package(url: "https://github.com/oversizedev/OversizeModels.git", .upToNextMajor(from: "0.1.0")),
    .package(url: "https://github.com/oversizedev/OversizeCore.git", .upToNextMajor(from: "1.3.0")),
    .package(url: "https://github.com/oversizedev/OversizeResources.git", .upToNextMajor(from: "2.0.0")),
    .package(url: "https://github.com/oversizedev/OversizeLocalizable.git", .upToNextMajor(from: "1.4.0")),
    .package(url: "https://github.com/hmlongco/Factory.git", .upToNextMajor(from: "2.1.3")),
    .package(url: "https://github.com/nicklockwood/SwiftFormat", .upToNextMajor(from: "0.52.10")),
]

let localDependencies: [PackageDescription.Package.Dependency] = [
    .package(name: "Database", path: "../Database"),
    .package(name: "Env", path: "../Env"),
    .package(name: "OversizeLocalizable", path: "../../../Packages/OversizeLocalizable"),
    .package(name: "OversizeResources", path: "../../../Packages/OversizeResources"),
    .package(name: "OversizeCore", path: "../../../Packages/OversizeCore"),
    .package(name: "OversizeModels", path: "../../../Packages/OversizeModels"),
    .package(name: "OversizeKit", path: "../../../Packages/OversizeKit"),
    .package(name: "OversizeServices", path: "../../../Packages/OversizeServices"),
    .package(name: "OversizeUI", path: "../../../Packages/OversizeUI"),
    .package(url: "https://github.com/hmlongco/Factory.git", .upToNextMajor(from: "2.1.3")),
    .package(url: "https://github.com/nicklockwood/SwiftFormat", .upToNextMajor(from: "0.52.10")),
]

let dependencies: [PackageDescription.Package.Dependency] = remoteDependencies

let package = Package(
    name: "App",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
        .watchOS(.v10),
    ],
    products: [
        .library(
            name: "App",
            targets: ["App"]
        ),
    ],
    dependencies: dependencies,
    targets: [
        .target(
            name: "App",
            dependencies: [
                .product(name: "Database", package: "Database"),
                .product(name: "Env", package: "Env"),
                .product(name: "OversizeResources", package: "OversizeResources"),
                .product(name: "OversizeModels", package: "OversizeModels"),
                .product(name: "OversizeCore", package: "OversizeCore"),
                .product(name: "OversizeLocalizable", package: "OversizeLocalizable"),
                .product(name: "OversizeKit", package: "OversizeKit"),
                .product(name: "OversizeServices", package: "OversizeServices"),
                .product(name: "OversizeHealthService", package: "OversizeServices"),
                .product(name: "OversizeStoreService", package: "OversizeServices"),
                .product(name: "Factory", package: "Factory"),
                .product(name: "OversizeUI", package: "OversizeUI"),
                .product(name: "OversizeNoticeKit", package: "OversizeKit"),
            ]
        ),
        .testTarget(
            name: "AppTests",
            dependencies: ["App"]
        ),
    ]
)
EOF

cd ..

# Create Screens package
mkdir Env
cd Env
swift package init --type library
# Replace content of Package.swift for Database package
cat <<EOF >Package.swift
// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import Foundation
import PackageDescription

let remoteDependencies: [PackageDescription.Package.Dependency] = [
    .package(url: "https://github.com/oversizedev/OversizeResources.git", .upToNextMajor(from: "2.0.0")),
    .package(url: "https://github.com/oversizedev/OversizeModels.git", .upToNextMajor(from: "0.1.0")),
    .package(url: "https://github.com/oversizedev/OversizeCore.git", .upToNextMajor(from: "1.3.0")),
    .package(url: "https://github.com/oversizedev/OversizeLocalizable.git", .upToNextMajor(from: "1.4.0")),
    .package(name: "Database", path: "../Database"),
]

let localDependencies: [PackageDescription.Package.Dependency] = [
    .package(name: "OversizeLocalizable", path: "../../../Packages/OversizeLocalizable"),
    .package(name: "OversizeCore", path: "../../../Packages/OversizeCore"),
    .package(name: "OversizeModels", path: "../../../Packages/OversizeModels"),
    .package(name: "OversizeResources", path: "../../../Packages/OversizeResources"),
    .package(name: "Database", path: "../Database"),
]

let dependencies: [PackageDescription.Package.Dependency] = remoteDependencies

let package = Package(
    name: "Env",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
        .watchOS(.v10),
    ],
    products: [
        .library(
            name: "Env",
            targets: ["Env"]
        ),
    ],
    dependencies: dependencies,
    targets: [
        .target(
            name: "Env",
            dependencies: [
                .product(name: "Database", package: "Database"),
                .product(name: "OversizeModels", package: "OversizeModels"),
                .product(name: "OversizeCore", package: "OversizeCore"),
                .product(name: "OversizeLocalizable", package: "OversizeLocalizable"),
                .product(name: "OversizeResources", package: "OversizeResources"),
            ]
        ),
        .testTarget(
            name: "EnvTests",
            dependencies: ["Env"]
        ),
    ]
)
EOF


