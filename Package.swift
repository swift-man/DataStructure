// swift-tools-version:5.1

import PackageDescription

let package = Package(name: "DataStructure",
                      platforms: [.macOS(.v10_12),
                                  .iOS(.v10),
                                  .tvOS(.v10),
                                  .watchOS(.v3)],
                      products: [.library(name: "DataStructure",
                                          targets: ["DataStructure"])],
                      targets: [.target(name: "DataStructure",
                                        path: "DataStructure"),
                                .testTarget(name: "DataStructureTests",
                                            dependencies: ["DataStructure"],
                                            path: "DataStructureTests")],
                      swiftLanguageVersions: [.v5])
