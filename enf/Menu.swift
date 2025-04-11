
import SwiftUI
import MapKit


struct Menu: View{
    @State private var selectedTab: Int = 0
    init() {
            // Set tab bar appearance
            UITabBar.appearance().backgroundColor = UIColor.systemGray6
        }
    var body: some View {
        
        TabView(selection: $selectedTab) { //Initialize Tabs
            MapView(searchManager: SearchManager(locations: locations)) //map
                .tabItem {
                    Label("Map",systemImage: "globe")
                }
                .tag(0)
            TipOfDay(selectedTab: $selectedTab)//myths and legends
                .tabItem {
                    Label("Tip of the Day",systemImage: "lightbulb.min")
                }
                .tag(1)
            EventView(events: events, selectedTab: $selectedTab)
                .tabItem {
                    Label("Events",systemImage: "calendar")
                }
                .tag(2)
        }.accentColor(Color.primary)
    }

}
