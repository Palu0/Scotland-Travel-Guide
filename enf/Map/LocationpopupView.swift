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
                        let dist = Int(distance(location1: location, location2: lastLocation))

                        HStack(spacing: 8) {
                            Text("\(dist) km")
                                .font(.subheadline)
                                .foregroundColor(.gray)

                            Image(systemName: weatherIcon)
                                .font(.subheadline)
                                .foregroundColor(.orange)

                            if let temp = temperature {
                                Text("\(Int(temp))°C")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        .onAppear {
                            fetchWeather(latitude: location.latitude, longitude: location.longitude)
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

    // MARK: - Fetch Weather from Open-Meteo
    func fetchWeather(latitude: Double, longitude: Double) {
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&current_weather=true"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }

            if let decoded = try? JSONDecoder().decode(OpenMeteoResponse.self, from: data) {
                DispatchQueue.main.async {
                    self.temperature = decoded.current_weather.temperature
                    self.weatherIcon = mapWeatherCodeToIcon(code: decoded.current_weather.weathercode)
                }
            }
        }.resume()
    }

    // MARK: - Weather Code → SF Symbol
    func mapWeatherCodeToIcon(code: Int) -> String {
        switch code {
        case 0: return "sun.max.fill"
        case 1, 2: return "cloud.sun.fill"
        case 3: return "cloud.fill"
        case 45, 48: return "cloud.fog.fill"
        case 51...67: return "cloud.drizzle.fill"
        case 71...77: return "cloud.snow.fill"
        case 80...82: return "cloud.heavyrain.fill"
        case 95: return "cloud.bolt.fill"
        case 96, 99: return "cloud.bolt.rain.fill"
        default: return "questionmark.circle"
        }
    }
}

// MARK: - Weather API Response Model
struct OpenMeteoResponse: Codable {
    let current_weather: WeatherData

    struct WeatherData: Codable {
        let temperature: Double
        let weathercode: Int
    }
}
