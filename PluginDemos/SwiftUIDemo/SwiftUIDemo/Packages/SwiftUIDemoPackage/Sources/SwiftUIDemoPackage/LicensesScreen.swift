import SwiftUI

struct LicensesScreen: View {
    var body: some View {
        List {
            ForEach(LicensesPlugin.licenses) { license in
                NavigationLink {
                    LicenseDetailScreen(license: license)
                } label: {
                    Text(license.name)
                }
            }
        }
        .navigationTitle("Licenses")
    }
}

struct LicensesScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LicensesScreen()
        }
    }
}
