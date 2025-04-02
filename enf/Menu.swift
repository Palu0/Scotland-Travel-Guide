
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
            TipOfDay()//myths and legends
                .tabItem {
                    Label("Tip of the Day",systemImage: "lightbulb.min")
                }
        }.accentColor(Color.primary)
    }

}
