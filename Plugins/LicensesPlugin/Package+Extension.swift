import Foundation
import PackagePlugin

extension Package {
    func getDependenciesRecursively() -> [Package] {
        var allDependencies: [Package] = []
        for dependency in dependencies {
            allDependencies.append(dependency.package)
            allDependencies.append(contentsOf: dependency.package.getDependenciesRecursively())
        }
        return allDependencies.uniqued()
    }
    
    func readLicenseText() -> String? {
        guard let fileURLs = try? FileManager.default.contentsOfDirectory(
            at: directoryURL,
            includingPropertiesForKeys: nil
        ) else { return nil }
        
        for fileURL in fileURLs {
            if fileURL.lastPathComponent.lowercased().hasPrefix("license") || fileURL.lastPathComponent.lowercased().hasPrefix("licence") {
                return try? String(contentsOf: fileURL, encoding: .utf8)
            }
        }
        return nil
    }
}

extension [Package] {
    func uniqued() -> [Package] {
        var new: [Package] = []
        for element in self {
            if !new.contains(where: { $0.id == element.id }) {
                new.append(element)
            }
        }
        return new
    }
}
