import SwiftUI
import MapKit
import CoreLocation

class SearchManager: ObservableObject {
    @Published var searchText: String = ""
    @Published var filteredLocations: [Location] = []

    init(locations: [Location]) {
        self.filteredLocations = locations
    }

    func search(in locations: [Location]) {
        if searchText.isEmpty {
            filteredLocations = locations
        } else {
            filteredLocations = locations.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
}

