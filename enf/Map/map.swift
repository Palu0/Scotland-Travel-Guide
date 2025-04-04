import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    @State private var hasSetRegion: Bool = false
    @StateObject var locationManager = LocationManager()
    @ObservedObject var searchManager: SearchManager
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 55.9533, longitude: -3.1883),
        span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07)
    )
    @State var selectedLocation: Location?
    var shouldShowAnnotations: [Location] {
        locations.filter { location in
            region.span.latitudeDelta < getZoomThreshold(for: location)
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(searchManager: searchManager, locations: locations)
                SearchResultsView(searchManager: searchManager, region: $region)

                ZStack {
                    Map(coordinateRegion: $region, showsUserLocation: true,
                        annotationItems: shouldShowAnnotations) { location in
                        MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)) {
                            Button(action: { selectedLocation = location }) {
                                Image(systemName: location.symbol ?? "mappin.circle.fill")
                                    .font(.title)
                                    .foregroundColor(location.color)
                            }
                            .buttonStyle(PlainButtonStyle())
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

                    if let selectedLocation = selectedLocation {
                        LocationPopupView(location: selectedLocation) {
                            self.selectedLocation = nil
                        }
                    }
                }
            }
        }
    }
}
