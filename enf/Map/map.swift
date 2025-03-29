import SwiftUI
import MapKit
import CoreLocation

// Location Struct
struct Location: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    let color: Color
    var description: String?
}

struct MapView: View {
    
    @StateObject private var locationManager = LocationManager()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 55.9533, longitude: -3.1883), // Default: Edinburgh
        span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07)
    )
    
    @State private var hasSetRegion = false
    @State private var selectedLocation: Location? // Track clicked location
    
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
        Location(name: "Fingal's Cave", latitude: 56.4337, longitude: -6.3350, color: .purple)
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                // Map with Clickable Annotations
                Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: locations) { location in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)) {
                        Button(action: {
                            selectedLocation = location // Update selected location
                        }) {
                            VStack {
                                Image(systemName: "mappin.circle.fill")
                                    .font(.title)
                                    .foregroundColor(location.color)
                            }
                        }
                    }
                }
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
                        .frame(width: screenWidth, height: screenHeight*0.3) // Make the width slightly smaller
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        .offset(y: 0.035*screenHeight)
                    }
                }
            }
        }
    }
}
