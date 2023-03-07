import XCTest

@testable import ExamplePackage

final class ExamplePackageTests: XCTestCase {
    func testLicenses() throws {
        let licenseNames = LicensesPlugin.licenses.map(\.name)
        XCTAssertEqual(
            licenseNames,
            [
                "BoringSSL-GRPC",
                "Firebase",
                "GTMSessionFetcher",
                "GoogleAppMeasurement",
                "GoogleDataTransport",
                "GoogleUtilities",
                "LicensesPlugin",
                "Promises",
                "SwiftGenPlugin",
                "SwiftProtobuf",
                "abseil",
                "combine-schedulers",
                "gRPC",
                "leveldb",
                "nanopb", 
                "swift-case-paths",
                "swift-clocks",
                "swift-collections",
                "swift-composable-architecture",
                "swift-custom-dump",
                "swift-dependencies",
                "swift-identified-collections",
                "swiftui-navigation",
                "xctest-dynamic-overlay"
            ]
        )
        
        // assert the uniqueness of id
        let licenseIDs = LicensesPlugin.licenses.map(\.id)
        XCTAssertEqual(licenseIDs.count, Set(licenseIDs).count, "id is not unique among licenses")
        
        // assert that licenseText is parsed for all the libraries
        for license in LicensesPlugin.licenses {
            XCTAssertNotNil(license.licenseText, "failed to parse license of \(license.name)")
        }
    }
}
