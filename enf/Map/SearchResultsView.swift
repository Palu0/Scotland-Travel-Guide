import SwiftUI
import MapKit
import CoreLocation

struct SearchResultsView: View {
    @ObservedObject var searchManager: SearchManager
    @Binding var region: MKCoordinateRegion
    @State public var isEditing: Bool = false
    var body: some View {
        if !searchManager.searchText.isEmpty {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(searchManager.filteredLocations) { location in
                        Button(action: {
                            region = MKCoordinateRegion(
                                center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude),
                                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                                
                            )
                            searchManager.searchText = ""
                            hideKeyboard()
                            
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
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    private func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
}

