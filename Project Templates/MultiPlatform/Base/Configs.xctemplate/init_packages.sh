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

let commonDependencies: [PackageDescription.Package.Dependency] = [
    .package(url: "https://github.com/nicklockwood/SwiftFormat", .upToNextMajor(from: "0.52.10")),
    .package(url: "https://github.com/hmlongco/Factory.git", .upToNextMajor(from: "2.1.3")),
]

let remoteDependencies: [PackageDescription.Package.Dependency] = commonDependencies + [
    .package(url: "https://github.com/oversizedev/OversizeCore.git", .upToNextMajor(from: "1.3.0")),
]

let localDependencies: [PackageDescription.Package.Dependency] = commonDependencies + [
    .package(name: "OversizeCore", path: "../../../Packages/OversizeCore"),
]

let isLocalDev = FileManager.default.fileExists(atPath: "\(NSHomeDirectory())/Developer/Packages/OversizeCore")
let dependencies: [PackageDescription.Package.Dependency] = isLocalDev ? localDependencies : remoteDependencies

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
                .product(name: "FactoryKit", package: "Factory"),
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

let commonDependencies: [PackageDescription.Package.Dependency] = [
    .package(name: "Database", path: "../Database"),
    .package(name: "Env", path: "../Env"),
    .package(url: "https://github.com/hmlongco/Factory.git", .upToNextMajor(from: "2.1.3")),
    .package(url: "https://github.com/fatbobman/ObservableDefaults.git", .upToNextMinor(from: "1.6.0")),
    .package(url: "https://github.com/nicklockwood/SwiftFormat", .upToNextMajor(from: "0.52.10"))
]

let remoteDependencies: [PackageDescription.Package.Dependency] = commonDependencies + [
    .package(url: "https://github.com/oversizedev/OversizeLocalizable.git", .upToNextMajor(from: "1.4.0")),
    .package(url: "https://github.com/oversizedev/OversizeResources.git", .upToNextMajor(from: "2.0.0")),
    .package(url: "https://github.com/oversizedev/OversizeCore.git", .upToNextMajor(from: "1.3.0")),
    .package(url: "https://github.com/oversizedev/OversizeKit.git", .upToNextMajor(from: "2.0.0")),
    .package(url: "https://github.com/oversizedev/OversizeUI.git", .upToNextMajor(from: "3.0.2")),
    .package(url: "https://github.com/oversizedev/OversizeServices.git", .upToNextMajor(from: "1.4.0")),
    .package(url: "https://github.com/oversizedev/OversizeNavigation.git", .upToNextMajor(from: "0.3.0")),
    .package(url: "https://github.com/oversizedev/OversizeComponents.git", .upToNextMajor(from: "2.0.0")),
    .package(url: "https://github.com/oversizedev/OversizeArchitecture.git", .upToNextMajor(from: "0.2.0")),
]

let localDependencies: [PackageDescription.Package.Dependency] = commonDependencies + [
    .package(name: "OversizeLocalizable", path: "../../../Packages/OversizeLocalizable"),
    .package(name: "OversizeResources", path: "../../../Packages/OversizeResources"),
    .package(name: "OversizeCore", path: "../../../Packages/OversizeCore"),
    .package(name: "OversizeKit", path: "../../../Packages/OversizeKit"),
    .package(name: "OversizeUI", path: "../../../Packages/OversizeUI"),
    .package(name: "OversizeServices", path: "../../../Packages/OversizeServices"),
    .package(name: "OversizeNavigation", path: "../../../Packages/OversizeNavigation"),
    .package(name: "OversizeComponents", path: "../../../Packages/OversizeComponents"),
    .package(name: "OversizeArchitecture", path: "../../../Packages/OversizeArchitecture"),
]

let isLocalDev = FileManager.default.fileExists(atPath: "\(NSHomeDirectory())/Developer/Packages/OversizeCore")
let dependencies: [PackageDescription.Package.Dependency] = isLocalDev ? localDependencies : remoteDependencies

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
        .library(name: "Main", targets: ["Main"]),
        .library(name: "Onboarding", targets: ["Onboarding"]),
        .library(name: "Settings", targets: ["Settings"]),
    ],
    dependencies: dependencies,
    targets: [
        .target(
            name: "Main",
            dependencies: [
                .product(name: "Database", package: "Database"),
                .product(name: "Env", package: "Env"),
                .product(name: "OversizeResources", package: "OversizeResources"),
                .product(name: "OversizeCore", package: "OversizeCore"),
                .product(name: "OversizeLocalizable", package: "OversizeLocalizable"),
                .product(name: "OversizeKit", package: "OversizeKit"),
                .product(name: "OversizeServices", package: "OversizeServices"),
                .product(name: "OversizeStoreService", package: "OversizeServices"),
                .product(name: "FactoryKit", package: "Factory"),
                .product(name: "OversizeUI", package: "OversizeUI"),
                .product(name: "OversizeNoticeKit", package: "OversizeKit"),
                .product(name: "OversizeNavigation", package: "OversizeNavigation"),
                .product(name: "ObservableDefaults", package: "ObservableDefaults"),
                .product(name: "OversizeArchitecture", package: "OversizeArchitecture"),
            ]
        ),
        .target(
            name: "Onboarding",
            dependencies: [
                .product(name: "Database", package: "Database"),
                .product(name: "Env", package: "Env"),
                .product(name: "OversizeOnboardingKit", package: "OversizeKit"),
                .product(name: "OversizeUI", package: "OversizeUI"),
                .product(name: "OversizeServices", package: "OversizeServices"),
                .product(name: "OversizeNavigation", package: "OversizeNavigation"),
                .product(name: "OversizeArchitecture", package: "OversizeArchitecture"),
                .product(name: "OversizeCore", package: "OversizeCore"),
                .product(name: "FactoryKit", package: "Factory"),
            ]
        ),
        .target(
            name: "Settings",
            dependencies: [
                .product(name: "Database", package: "Database"),
                .product(name: "Env", package: "Env"),
                .product(name: "OversizeUI", package: "OversizeUI"),
                .product(name: "OversizeArchitecture", package: "OversizeArchitecture"),
                .product(name: "FactoryKit", package: "Factory"),
                .product(name: "OversizeNavigation", package: "OversizeNavigation"),
            ]
        ),
        .testTarget(name: "MainTests", dependencies: ["Main"]),
        .testTarget(name: "OnboardingTests", dependencies: ["Onboarding"]),
        .testTarget(name: "SettingsTests", dependencies: ["Settings"]),
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
    .package(url: "https://github.com/oversizedev/OversizeCore.git", .upToNextMajor(from: "1.3.0")),
    .package(url: "https://github.com/oversizedev/OversizeLocalizable.git", .upToNextMajor(from: "1.4.0")),
    .package(url: "https://github.com/oversizedev/OversizeUI.git", .upToNextMajor(from: "3.0.2")),
    .package(url: "https://github.com/oversizedev/OversizeNavigation.git", .upToNextMajor(from: "0.3.0")),
    .package(name: "Database", path: "../Database"),
]

let localDependencies: [PackageDescription.Package.Dependency] = [
    .package(name: "OversizeLocalizable", path: "../../../Packages/OversizeLocalizable"),
    .package(name: "OversizeCore", path: "../../../Packages/OversizeCore"),
    .package(name: "OversizeResources", path: "../../../Packages/OversizeResources"),
    .package(name: "OversizeUI", path: "../../../Packages/OversizeUI"),
    .package(name: "OversizeNavigation", path: "../../../Packages/OversizeNavigation"),
    .package(name: "Database", path: "../Database"),
]

let isLocalDev = FileManager.default.fileExists(atPath: "\(NSHomeDirectory())/Developer/Packages/OversizeCore")
let dependencies: [PackageDescription.Package.Dependency] = isLocalDev ? localDependencies : remoteDependencies

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
                .product(name: "OversizeCore", package: "OversizeCore"),
                .product(name: "OversizeLocalizable", package: "OversizeLocalizable"),
                .product(name: "OversizeResources", package: "OversizeResources"),
                .product(name: "OversizeUI", package: "OversizeUI"),
                .product(name: "OversizeNavigation", package: "OversizeNavigation"),
            ]
        ),
        .testTarget(
            name: "EnvTests",
            dependencies: ["Env"]
        ),
    ]
)
EOF


