import Foundation
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
                "TrickyLicense",
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
    
    func testTrickyLicenseTextIsReproducedVerbatim() throws {
        let license = try XCTUnwrap(
            LicensesPlugin.licenses.first(where: { $0.name == "TrickyLicense" }),
            "the TrickyLicense fixture is missing from the generated licenses"
        )
        let fixtureText = try String(contentsOf: Self.trickyLicenseFixtureURL, encoding: .utf8)
        
        // assert the fixture still contains every construct a naive string literal cannot hold
        for construct in ["\\", "\\n", "\\q", "\\(", "\\#n", "\"\"\"", "\"\"\"#"] {
            XCTAssertTrue(
                fixtureText.contains(construct),
                "the TrickyLicense fixture no longer contains \(construct.debugDescription)"
            )
        }
        
        XCTAssertEqual(license.licenseText, fixtureText)
    }
    
    // PluginTests/TrickyLicense/LICENSE, relative to this file
    private static var trickyLicenseFixtureURL: URL {
        URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .appendingPathComponent("TrickyLicense")
            .appendingPathComponent("LICENSE")
    }
}
