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
    
    func testLicenseURLs() throws {
        func url(of name: String) throws -> URL? {
            try XCTUnwrap(
                LicensesPlugin.licenses.first(where: { $0.name == name }),
                "\(name) is missing from the generated licenses"
            ).url
        }
        
        // urls are emitted as declared in the manifest, so a `.git` suffix is preserved as-is
        XCTAssertEqual(try url(of: "Firebase"), URL(string: "https://github.com/firebase/firebase-ios-sdk"))
        XCTAssertEqual(try url(of: "leveldb"), URL(string: "https://github.com/firebase/leveldb.git"))
        
        // a dependency referenced by path has no repository url
        XCTAssertNil(try url(of: "LicensesPlugin"))
        
        // assert that url is resolved for all the remote libraries
        for license in LicensesPlugin.licenses where license.name != "LicensesPlugin" {
            XCTAssertNotNil(license.url, "failed to resolve url of \(license.name)")
        }
    }
}
