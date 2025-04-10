import SwiftUI
import CoreLocation

struct LocationPopupView: View {
    let location: Location
    let onClose: () -> Void
    @StateObject var locationManager = LocationManager()
    @State private var isMenuOpen: Bool = false
    @State private var temperature: Double?
    @State private var weatherIcon: String = "questionmark.circle"
    
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
                
                // Description Toggle + Distance + Weather
                HStack {
                    Button(action: { isMenuOpen.toggle() }) {
                        Text(isMenuOpen ? "Read less" : "Read more")
                            .fontWeight(.medium)
                            .foregroundColor(.blue)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                    
                    if let lastLocation = locationManager.lastLocation {
                        let dist = distance(location1: location, location2: lastLocation)
                        
                        HStack(spacing: 8) {
                            Text("\(dist) km")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            Image(systemName: weatherIcon)
                                .font(.subheadline)
                                .foregroundColor(.yellow)
                            
                            if let temp = temperature {
                                Text("\(Int(temp))°C")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        .onAppear {
                            WeatherManager.shared.fetchWeather(latitude: location.latitude, longitude: location.longitude) { temp, icon in
                                self.temperature = temp
                                self.weatherIcon = icon
                            }
                        }
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
