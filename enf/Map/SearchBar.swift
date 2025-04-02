import SwiftUI
import CoreLocation

struct SearchBar: View {
    @ObservedObject var searchManager: SearchManager
    @FocusState private var isTextFieldFocused: Bool
    let locations: [Location]

    var body: some View {
        TextField("Search...", text: $searchManager.searchText)
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .onChange(of: searchManager.searchText) { _ in
                searchManager.search(in: locations)
            }
            .focused($isTextFieldFocused)
            .onSubmit {
                isTextFieldFocused = false
            }
    }
}
