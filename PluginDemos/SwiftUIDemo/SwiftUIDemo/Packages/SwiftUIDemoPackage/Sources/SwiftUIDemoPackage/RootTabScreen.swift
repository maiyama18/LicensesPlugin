import SwiftUI

public struct RootTabScreen: View {
    public init() {}
    
    public var body: some View {
        TabView {
            NavigationView {
                MainScreen()
            }
            .tabItem {
                Label("Main", systemImage: "star")
            }
            
            NavigationView {
                SettingsScreen()
            }
            .tabItem {
                Label("Settings", systemImage: "gearshape")
            }
        }
    }
}
