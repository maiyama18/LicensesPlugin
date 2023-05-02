import Foundation

@main
enum CopyLicensesFile {
    private static let fileManager = FileManager.default
    
    static func main() throws {
        guard CommandLine.arguments.count == 3 else {
            print("This executable should be called with 2 arguments: CopyLicensesFile <source path> <destination path>")
            exit(1)
        }
        let sourcePath = CommandLine.arguments[1]
        let destinationPath = CommandLine.arguments[2]
        
        do {
            if fileManager.fileExists(atPath: destinationPath) {
                try fileManager.removeItem(atPath: destinationPath)
            }
            try fileManager.copyItem(atPath: sourcePath, toPath: destinationPath)
        } catch {
            print("Failed to copy licenses file: \(error)")
            exit(1)
        }
    }
}
