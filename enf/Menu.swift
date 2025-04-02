
import SwiftUI
import MapKit


struct Menu: View{
    init() {
            // Set tab bar appearance
            UITabBar.appearance().backgroundColor = UIColor.systemGray6
        }
    var body: some View {
        
        TabView { //Initialize Tabs
            MapView(searchManager: SearchManager(locations: locations)) //map
                .tabItem {
                    Label("Map",systemImage: "globe")
                }
            myths()//myths and legends
                .tabItem {
                    Label("Settings",systemImage: "gear")
                }
        }.accentColor(Color.primary)
    }

}
