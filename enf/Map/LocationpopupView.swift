import SwiftUI

struct LocationPopupView: View {
    let location: Location
    let onClose: () -> Void
    @StateObject var locationManager = LocationManager()
    @State private var isMenuOpen: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(location.name)
                        .font(.title)
                    Image(systemName: location.symbol ?? "globe")
                    Spacer()
                    Button(action: onClose) {
                        Image(systemName: "xmark.circle")
                    }
                }
                Image(location.name)
                    .resizable()
                    .scaledToFit()
                HStack {
                    Button(isMenuOpen ? "read less" : "read more"){
                        isMenuOpen.toggle()
                    }
                    .menuStyle(BorderlessButtonMenuStyle())
                    Spacer()
                    if let lastLocation = locationManager.lastLocation {
                        Text("\((distance(location1: location, location2: lastLocation))) nm")
                    }
                }
                if isMenuOpen {
                    Text(location.description ?? "nothing to see here :(")
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .shadow(radius: 5)
        }
        .offset(y: +10)
    }
}
