import XCTest

@testable import ExamplePackage

final class ExamplePackageTests: XCTestCase {
    func testLicenses() throws {
        let licenseNames = LicensesPlugin.licenses.map(\.name)
        XCTAssertEqual(
            licenseNames,
            [
                "abseil",
                "AppCheck",
                "combine-schedulers",
                "Firebase",
                "GoogleAppMeasurement",
                "GoogleDataTransport",
                "GoogleUtilities",
                "gRPC",
                "GTMSessionFetcher",
                "InteropForGoogle",
                "leveldb",
                "LicensesPlugin",
                "nanopb",
                "Promises",
                "swift-case-paths",
                "swift-clocks",
                "swift-collections",
                "swift-composable-architecture",
                "swift-concurrency-extras",
                "swift-custom-dump",
                "swift-dependencies",
                "swift-identified-collections",
                "swift-perception",
                "swift-syntax",
                "SwiftGenPlugin",
                "SwiftProtobuf",
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
