import SwiftUI
import CoreLocation

struct SearchBar: View {
    @ObservedObject var searchManager: SearchManager
    let locations: [Location]

    var body: some View {
        TextField("Search...", text: $searchManager.searchText)
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .onChange(of: searchManager.searchText) { _ in
                searchManager.search(in: locations)
            }
    }
}
