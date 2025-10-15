// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SupportChatKit",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "SupportChatKit",
            targets: ["SupportChatKit"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "12.4.0")
    ],
    targets: [
        .target(
            name: "SupportChatKit",
            dependencies: [
                .product(name: "FirebaseFirestore", package: "firebase-ios-sdk"),
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk")
            ],
            resources: [
                .process("Resources")
            ]
        ),
    ]
)
/*
 import PackageDescription

 let package = Package(
     name: "AdsManager",
     platforms: [
         .iOS(.v15) // <- minimum iOS version is 15
     ],
     products: [
         // Products define the executables and libraries a package produces, making them visible to other packages.
         .library(
             name: "AdsManager",
             targets: ["AdsManager"]),
     ],
     dependencies: [
         .package(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads", from: "12.12.0")
     ],
     targets: [
         // Targets are the basic building blocks of a package, defining a module or a test suite.
         // Targets can depend on other targets in this package and products from dependencies.
         .target(
             name: "AdsManager",
             dependencies: [
                 .product(name: "GoogleMobileAds", package: "swift-package-manager-google-mobile-ads")
             ],
             resources: [
                 .process("Resources")
             ]
         ),
             
     ],
 )

 */
