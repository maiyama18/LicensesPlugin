# LicensesPlugin

⚠️ This plugin is currently in an experimental phase and may contain bugs. It would be greatly appreciated if you could report wrong behavior in an issue .

LicensesPlugin is a swift package plugin that provides license information of the libraries your swift package depends on. Currently, the licenses of only swift packages are collected.

This plugin has the following features.

- License information is automatically updated during build process. No manual command execution needed
- You can make custom UI to show the licenses. This plugin only provides data of the licenses, not UI containing them

## Installation

Just add the package to your `Package.swift`.

```swift
let package = Package(
    // ...
    dependencies: [
        .package(url: "https://github.com/maiyama18/LicensesPlugin", from: "0.1.0")
    ],
    // ...
)
```

## Usage

Apply the plugin as the dependency of the target you can show licenses.

```swift
let package = Package(
    // ...
    
    targets: [
        // ...
        
        .target(
            name: "SomeFeature",
            plugins: [
                .plugin(name: "LicensesPlugin", package: "LicensesPlugin"),
            ]
        ),
        
        // ...
    ]
    
    // ...
)
```

In the target the plugin applied, you can use `LicensesPlugin.licenses` to make UI showing the licenses. The type of the elements of `LicensePlugin.licenses` is below.

```swift
public enum LicensesPlugin {
    public struct License: Identifiable, Equatable, Hashable {
        public let id: String
        public let name: String
        public let licenseText: String?
    }
}
```

For example, you can construct the UI like this.

```swift
/// SomeFeature/LicensesScreen.swift

struct LicensesScreen: View {
    @State private var selectedLicense: LicensesPlugin.License?
    
    var body: some View {
        List {
            ForEach(LicensesPlugin.licenses) { license in
                Button {
                    selectedLicense = license
                } label: {
                    Text(license.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .sheet(item: $selectedLicense) { license in
            NavigationStack {
                Group {
                    if let licenseText = license.licenseText {
                        ScrollView {
                            Text(licenseText)
                                .padding()
                        }
                    } else {
                        Text("No License Found")
                    }
                }
                .navigationTitle(license.name)
            }
        }
        .navigationTitle("Licenses")
    }
}
```

(gif here)

Note that this plugin provides the licenses of all the libraries your **swift package** depends on, not just the target this plugin applied depends on.
