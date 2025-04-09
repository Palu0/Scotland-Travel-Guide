import SwiftUI

struct LocationPopupView: View {
    let location: Location
    let onClose: () -> Void
    @StateObject var locationManager = LocationManager()
    @State private var isMenuOpen: Bool = false

    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text(location.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    Image(systemName: location.symbol ?? "globe")
                        .foregroundColor(.blue)
                    Spacer()
                    Button(action: onClose) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
                
                // Location Image
                Image(location.name)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .shadow(radius: 8)
                    .padding(.vertical)

                // Description Toggle
                HStack {
                    Button(action: { isMenuOpen.toggle() }) {
                        Text(isMenuOpen ? "Read less" : "Read more")
                            .fontWeight(.medium)
                            .foregroundColor(.blue)
                    }
                    .buttonStyle(PlainButtonStyle())

                    Spacer()

                    if let lastLocation = locationManager.lastLocation {
                        Text("\(Int(distance(location1: location, location2: lastLocation))) km")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }

                // Description Text
                if isMenuOpen {
                    Text(location.description ?? "Nothing to see here :(")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .padding(.top, 8)
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(15)
            .shadow(radius: 10)
            .padding([.horizontal, .bottom], 16)
        }
        .offset(y: 10)
    }
}
