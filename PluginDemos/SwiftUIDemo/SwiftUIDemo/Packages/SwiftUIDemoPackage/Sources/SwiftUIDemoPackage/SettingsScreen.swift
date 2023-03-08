import SwiftUI

struct SettingsScreen: View {
    var body: some View {
        List {
            Section {
                NavigationLink {
                    LicensesScreen()
                } label: {
                    Text("Licenses")
                }
            } header: {
                Text("About App")
            }

        }
        .navigationTitle("Settings")
    }
}
