import PackageDescription

let package = Package(
    name: "SwiftMan/DataStructure",
    platforms: [
        .iOS, .macOS, .tvOS, .watchOS
    ],
    products: [
        .library(name: "SwiftMan/DataStructure",
                 targets: ["DataStructure"])
    ],
    targets: [
        .target(name: "DataStructure",
                path: "DataStructure/Classes")
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
