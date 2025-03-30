import SwiftUI
import MapKit
import CoreLocation
//moogen
// Location Struct
struct Location: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    let color: Color
    var description: String?
    var symbol: String?
}

// Search class
class Search {
    func search(input: String, in array: [Location]) -> [Location] {
        let lowercasedInput = input.lowercased()
        return array.filter { location in
            location.name.lowercased().contains(lowercasedInput) //returns matching outputs
        }
    }
}


struct MapView: View {
    
    @StateObject private var locationManager = LocationManager()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 55.9533, longitude: -3.1883), // Default: Edinburgh
        span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07)
    )
    
    @State private var hasSetRegion = false
    @State private var selectedLocation: Location? // Track clicked location
    @State private var searchText = ""  // Track user input
    @State private var filteredLocations: [Location] // Stores search results
    
    
    //list of all locations
    let locations: [Location] = [
        // 🔴 Events
        Location(name: "Highland Games", latitude: 56.8169, longitude: -5.1128, color: .red, description: "UWUWUWUWUUWUWUWUWUWWUWUUWUWWUWUW"),
        Location(name: "Edinburgh Fringe Festival", latitude: 55.9533, longitude: -3.1883, color: .red),
        Location(name: "Tall Ships Races", latitude: 57.1499, longitude: -2.0938, color: .red),
        
        // 🔵 Points of Interest (POI)
        Location(name: "Loch Ness", latitude: 57.3229, longitude: -4.4244, color: .blue),
        Location(name: "Arthur's Seat", latitude: 55.9445, longitude: -3.1618, color: .blue),
        
        // 🟢 History
        Location(name: "Palace of Holyroodhouse", latitude: 55.9525, longitude: -3.1725, color: .green),
        Location(name: "Dunnottar Castle", latitude: 56.9450, longitude: -2.1970, color: .green),
        
        // 🟣 Myths & Legends
        Location(name: "Loch Ness Monster", latitude: 57.3229, longitude: -4.4244, color: .purple),
        Location(name: "Fingal's Cave", latitude: 56.4337, longitude: -6.3350, color: .purple, symbol: "mountain.2.fill")
    ]
    // Initialize with all locations
    private let search = Search()
    
    init() {
        _filteredLocations = State(initialValue: locations)
    }
    
    var body: some View {
        NavigationView {
            GeometryReader {geometry in // GeometryReader fixes bug resizing the map when typing in the search area
            VStack {
                // Search Bar
                TextField("Search...", text: $searchText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onChange(of: searchText) { newValue in
                        if newValue.isEmpty {
                            filteredLocations = locations
                        } else {
                            filteredLocations = search.search(input: newValue, in: locations)
                        }
                    }
                //displays search results
                if !searchText.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(filteredLocations) { location in
                                Button(action: { //clicking recenters the map
                                    region = MKCoordinateRegion(
                                        center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude),
                                        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                                    )
                                }) {
                                    VStack {
                                        Image(systemName: location.symbol ?? "mappin.circle.fill")
                                            .font(.largeTitle)
                                            .foregroundColor(location.color)
                                        Text(location.name)
                                            .font(.caption)
                                            .padding(.horizontal, 5)
                                    }
                                    .padding(8)
                                    .background(selectedLocation?.id == location.id ? Color.gray.opacity(0.2) : Color.clear)
                                    .cornerRadius(8)
                                }
                            }
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .ignoresSafeArea(.all)
                }
                
                ZStack {
                        // Map with Clickable Annotations
                        Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: locations) { location in
                            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)) {
                                Button(action: {
                                    selectedLocation = location // Update selected location
                                })
                                {
                                    //displays mappin if no symbol is declared in location list
                                    Image(systemName:location.symbol ?? "mappin.circle.fill")
                                        .font(.title)
                                        .foregroundColor(location.color)
                                }
                                //removes the rectangle around the button
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .onReceive(locationManager.$lastLocation) { newLocation in
                            if let newLocation = newLocation, !hasSetRegion {
                                region = MKCoordinateRegion(
                                    center: newLocation.coordinate,
                                    span: MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.7)
                                )
                                hasSetRegion = true
                            }
                        }
                        .edgesIgnoringSafeArea(.all)
                        
                        
                        // Custom Popup for Selected Location
                        if let selectedLocation = selectedLocation {
                            // Fetch screen dimensions
                            let screenSize = UIScreen.main.bounds
                            let screenWidth = screenSize.width
                            let screenHeight = screenSize.height
                            // Button funcionality
                            VStack{
                                Spacer()
                                
                                VStack(alignment: .leading, spacing: 5) { // Adjust spacing
                                    HStack {
                                        Text(selectedLocation.name)
                                            .font(.headline)
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            self.selectedLocation = nil
                                        }) {
                                            Image(systemName: "xmark.circle")
                                        }
                                    }
                                    
                                    Text(selectedLocation.description ?? "No description available.")
                                        .font(.subheadline)
                                }
                                .padding(10) // Reduce padding here
                                // .frame(width: screenWidth, height: screenHeight*0.3) // Make the width slightly smaller
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                                // .cornerRadius(15)
                                //.offset(y: 0.035*screenHeight)
                                .shadow(radius: 5)
                            }
                            .offset(y: -57)//moving everything down so that the round corners aren't visible anymore
                        }
                    }
                }
            }
        }
        //mogen
    }
}
