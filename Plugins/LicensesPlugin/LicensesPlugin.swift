import Foundation
import PackagePlugin

@main struct Plugin: BuildToolPlugin {
    func createBuildCommands(context: PackagePlugin.PluginContext, target: PackagePlugin.Target) async throws -> [PackagePlugin.Command] {
        let dependencies = context.package.getDependenciesRecursively()
        let sortedDependencies = Array(dependencies).sorted(by: { $0.displayName < $1.displayName })
        let generatedLicensesText = sortedDependencies.map {
            if let licenseText = $0.readLicenseText() {
                return """
            License(
                id: \"\($0.id)\",
                name: \"\($0.displayName)\",
                licenseText: \"\"\"
            \(licenseText)
            \"\"\"
            )
            """
            } else {
                return """
            License(
                id: \"\($0.id)\",
                name: \"\($0.displayName)\",
                licenseText: nil
            )
            """
            }
        }.joined(separator: ",\n")
        
        let generatedFileContent = """
        public enum LicensesPlugin {
            public struct License: Identifiable, Equatable, Hashable {
                public let id: String
                public let name: String
                public let licenseText: String?
            }
        
            public static let licenses: [License] = [
                \(generatedLicensesText)
            ]
        }
        """
        
        let tmpOutputFilePathString = try tmpOutputFilePath(workDirectory: context.pluginWorkDirectory).string
        try generatedFileContent.write(to: URL(fileURLWithPath: tmpOutputFilePathString), atomically: true, encoding: .utf8)
        
        let outputFilePath = try outputFilePath(workDirectory: context.pluginWorkDirectory)
        
        return [
            .prebuildCommand(
                displayName: "LicensesPlugin",
                executable: try context.tool(named: "cp").path,
                arguments: [tmpOutputFilePathString, outputFilePath.string],
                outputFilesDirectory: outputFilePath.removingLastComponent()
            )
        ]
    }
    
    private let generatedFileName = "Licenses+Generated.swift"
    
    private func tmpOutputFilePath(workDirectory: Path) throws -> Path {
        let tmpDirectory = Path(NSTemporaryDirectory())
        try FileManager.default.createDirectoryIfNotExists(atPath: tmpDirectory.string)
        return tmpDirectory.appending(generatedFileName)
    }
    
    private func outputFilePath(workDirectory: Path) throws -> Path {
        let outputDirectory = workDirectory.appending("Output")
        try FileManager.default.createDirectoryIfNotExists(atPath: outputDirectory.string)
        return outputDirectory.appending("Licenses+Generated.swift")
    }
}
