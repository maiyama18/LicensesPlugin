import Foundation
import PackagePlugin

extension Package: Hashable {
    public static func == (lhs: PackagePlugin.Package, rhs: PackagePlugin.Package) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Package {
    func getDependenciesRecursively() -> Set<Package> {
        var allDependencies: Set<Package> = .init()
        for dependency in dependencies {
            allDependencies.insert(dependency.package)
            allDependencies.formUnion(dependency.package.getDependenciesRecursively())
        }
        return allDependencies
    }
    
    func readLicenseText() -> String? {
        guard let fileURLs = try? FileManager.default.contentsOfDirectory(
            at: URL(fileURLWithPath: directory.string),
            includingPropertiesForKeys: nil
        ) else { return nil }
        
        for fileURL in fileURLs {
            if fileURL.lastPathComponent.lowercased().hasPrefix("license") || fileURL.lastPathComponent.lowercased().hasPrefix("licence") {
                return try? String(contentsOf: fileURL)
            }
        }
        return nil
    }
}
