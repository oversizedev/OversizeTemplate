#!/bin/bash

mkdir Packages
cd Packages

# Create Database package
mkdir Database
cd Database
swift package init --type library
# Replace content of Package.swift for Database package
cat <<EOF >Package.swift
// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import Foundation
import PackageDescription

let productionDependencies: [PackageDescription.Package.Dependency] = [
    .package(url: "https://github.com/oversizedev/OversizeCore.git", .upToNextMajor(from: "1.3.0")),
    .package(url: "https://github.com/SwiftGen/SwiftGenPlugin", .upToNextMajor(from: "6.6.2")),
    .package(url: "https://github.com/nicklockwood/SwiftFormat", .upToNextMajor(from: "0.52.10")),
]

let developmentDependencies: [PackageDescription.Package.Dependency] = [
    .package(name: "OversizeCore", path: "../../../OversizeLibrary/OversizeCore"),
    .package(url: "https://github.com/SwiftGen/SwiftGenPlugin", .upToNextMajor(from: "6.6.2")),
    .package(url: "https://github.com/nicklockwood/SwiftFormat", .upToNextMajor(from: "0.52.10")),
]

let dependencies: [PackageDescription.Package.Dependency] = developmentDependencies

let package = Package(
    name: "Database",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16),
        .macOS(.v14),
        .tvOS(.v16),
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
            ],
            plugins: [
                .plugin(name: "SwiftGenPlugin", package: "SwiftGenPlugin"),
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
// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import Foundation
import PackageDescription

let productionDependencies: [PackageDescription.Package.Dependency] = [
    .package(name: "Database", path: "../Database"),
    .package(name: "Env", path: "../Env"),
    .package(url: "https://github.com/oversizedev/OversizeKit.git", .upToNextMajor(from: "1.2.0")),
    .package(url: "https://github.com/oversizedev/OversizeUI.git", .upToNextMajor(from: "3.0.2")),
    .package(url: "https://github.com/oversizedev/OversizeServices.git", .upToNextMajor(from: "1.4.0")),
    .package(url: "https://github.com/oversizedev/OversizeModels.git", .upToNextMajor(from: "0.1.0")),
    .package(url: "https://github.com/oversizedev/OversizeCore.git", .upToNextMajor(from: "1.3.0")),
    .package(url: "https://github.com/oversizedev/OversizeResources.git", .upToNextMajor(from: "2.0.0")),
    .package(url: "https://github.com/oversizedev/OversizeLocalizable.git", .upToNextMajor(from: "1.4.0")),
    .package(url: "https://github.com/hmlongco/Factory.git", .upToNextMajor(from: "2.1.3")),
    .package(url: "https://github.com/nicklockwood/SwiftFormat", .upToNextMajor(from: "0.52.10")),
]

let developmentDependencies: [PackageDescription.Package.Dependency] = [
    .package(name: "Database", path: "../Database"),
    .package(name: "Env", path: "../Env"),
    .package(name: "OversizeLocalizable", path: "../../../OversizeLibrary/OversizeLocalizable"),
    .package(name: "OversizeResources", path: "../../../OversizeLibrary/OversizeResources"),
    .package(name: "OversizeCore", path: "../../../OversizeLibrary/OversizeCore"),
    .package(name: "OversizeModels", path: "../../../OversizeLibrary/OversizeModels"),
    .package(name: "OversizeKit", path: "../../../OversizeLibrary/OversizeKit"),
    .package(name: "OversizeServices", path: "../../../OversizeLibrary/OversizeServices"),
    .package(name: "OversizeUI", path: "../../../OversizeLibrary/OversizeUI"),
    .package(url: "https://github.com/hmlongco/Factory.git", .upToNextMajor(from: "2.1.3")),
    .package(url: "https://github.com/nicklockwood/SwiftFormat", .upToNextMajor(from: "0.52.10")),
]

let dependencies: [PackageDescription.Package.Dependency] = developmentDependencies

let package = Package(
    name: "App",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16),
        .macOS(.v14),
        .tvOS(.v16),
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
// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import Foundation
import PackageDescription

let productionDependencies: [PackageDescription.Package.Dependency] = [
    .package(url: "https://github.com/oversizedev/OversizeResources.git", .upToNextMajor(from: "2.0.0")),
    .package(url: "https://github.com/oversizedev/OversizeModels.git", .upToNextMajor(from: "0.1.0")),
    .package(url: "https://github.com/oversizedev/OversizeCore.git", .upToNextMajor(from: "1.3.0")),
    .package(url: "https://github.com/oversizedev/OversizeLocalizable.git", .upToNextMajor(from: "1.4.0")),
    .package(name: "Database", path: "../Database"),
]

let developmentDependencies: [PackageDescription.Package.Dependency] = [
    .package(name: "OversizeLocalizable", path: "../../../OversizeLibrary/OversizeLocalizable"),
    .package(name: "OversizeCore", path: "../../../OversizeLibrary/OversizeCore"),
    .package(name: "OversizeModels", path: "../../../OversizeLibrary/OversizeModels"),
    .package(name: "OversizeResources", path: "../../../OversizeLibrary/OversizeResources"),
    .package(name: "Database", path: "../Database"),
]

let dependencies: [PackageDescription.Package.Dependency] = developmentDependencies

let package = Package(
    name: "Env",
    platforms: [
        .iOS(.v16),
        .macOS(.v14),
        .tvOS(.v16),
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


cd ..

# Create main.swift in the main directory
#echo "import Database" > main.swift
#echo "import Model" >> main.swift
#echo "import Screens" >> main.swift
#echo "print(\"Swift code running!\")" >> main.swift
# Run Swift code
# main.swift

## Generate project
cd ..

#Database
mv ___VARIABLE_productName:RFC1034Identifier___/Database/PersistenceController.swift Packages/Database/Sources/Database
mv ___VARIABLE_productName:RFC1034Identifier___/Database/___VARIABLE_productName:RFC1034Identifier___.xcdatamodeld Packages/Database/Sources/Database
mv ___VARIABLE_productName:RFC1034Identifier___/Models/ItemExtension.swift Packages/Database/Sources/Database
mkdir Packages/Database/Templates/
mv ___VARIABLE_productName:RFC1034Identifier___/Resources/Templates/CoreDataTemplate.stencil Packages/Database/Templates/
mv ___VARIABLE_productName:RFC1034Identifier___/App/swiftgen.yml Packages/Database/
rm ___VARIABLE_productName:RFC1034Identifier___/Models/CoreData.swift
rmdir ___VARIABLE_productName:RFC1034Identifier___/Database/
rmdir ___VARIABLE_productName:RFC1034Identifier___/Models/
rmdir ___VARIABLE_productName:RFC1034Identifier___/Resources/Templates/

#Env
mv ___VARIABLE_productName:RFC1034Identifier___/Router/Alerts.swift Packages/Env/Sources/Env/
mv ___VARIABLE_productName:RFC1034Identifier___/Router/Router.swift Packages/Env/Sources/Env/
mv ___VARIABLE_productName:RFC1034Identifier___/Router/Screens.swift Packages/Env/Sources/Env/
mv ___VARIABLE_productName:RFC1034Identifier___/Router/Tabs.swift Packages/Env/Sources/Env/

#App
mv ___VARIABLE_productName:RFC1034Identifier___/Screens/AppSettings/ Packages/App/Sources/App/
mv ___VARIABLE_productName:RFC1034Identifier___/Screens/Main/ Packages/App/Sources/App/
mv ___VARIABLE_productName:RFC1034Identifier___/Screens/Onboarding/ Packages/App/Sources/App/
rmdir ___VARIABLE_productName:RFC1034Identifier___/Screens/
mv ___VARIABLE_productName:RFC1034Identifier___/Assets.xcassets ___VARIABLE_productName:RFC1034Identifier___/Resources/
mv ___VARIABLE_productName:RFC1034Identifier___/Info.plist ___VARIABLE_productName:RFC1034Identifier___/App/

# Insert the imports
sed -i '' '6i\
import Database\
import Env\
' Packages/App/Sources/App/Main/MainView.swift

sed -i '' '6i\
import Database\
' Packages/Env/Sources/Env/Screens.swift

sed -i '' '6i\
import App\
import Database\
import Env\
' ___VARIABLE_productName:RFC1034Identifier___/___VARIABLE_productName:RFC1034Identifier___App.swift

sed -i '' '6i\
import App\
import Env\
' ___VARIABLE_productName:RFC1034Identifier___/Router/ResolveRouter.swift

sed -i '' 's/Bundle\.main\.url(forResource: "___VARIABLE_productName:RFC1034Identifier___", withExtension: "momd")!/Bundle.module.url(forResource: "___VARIABLE_productName:RFC1034Identifier___", withExtension: "momd")!/' "Packages/Database/Sources/Database/PersistenceController.swift"

#SwiftGen config

cat <<EOF >Packages/Database/swiftgen.yml
input_dir: Sources/Database/
output_dir: \${DERIVED_SOURCES_DIR}

coredata:
  - inputs:
      - ___VARIABLE_productName:RFC1034Identifier___.xcdatamodeld
    outputs:
      - templatePath: Templates/CoreDataTemplate.stencil
        output: ___VARIABLE_productName:RFC1034Identifier___CoreData.swift
        params:
          generateObjcName: true
          publicAccess: 1

EOF

xcodegen


open ___VARIABLE_productName:RFC1034Identifier___.xcodeproj

osascript -e 'quit app "Xcode"'

open ___VARIABLE_productName:RFC1034Identifier___.xcodeproj

rm createPackages.sh
