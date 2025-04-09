import SwiftUI
import CoreLocation

var randomlocation: Location? = locations.randomElement()
var selectedLocationTip: Location?

struct TipOfDay: View {
    @StateObject var locationManager = LocationManager()
    @Binding var selectedTab: Int
    @StateObject private var weatherManager = WeatherManager()
    
    @State private var temperature: Double?
    @State private var weatherIcon: String = "questionmark.circle"

    var body: some View {
        VStack(spacing: 16) {
            Text("Your Tip of the Day!")
                .font(.headline)
                .padding(.top)

            HStack(spacing: 8) {
                Text("Let's visit \(randomlocation?.name ?? "No locations available")")
                    .font(.title2)
                    .fontWeight(.semibold)
                Image(systemName: randomlocation?.symbol ?? "mappin.and.ellipse")
                    .imageScale(.large)
            }

            if let description = randomlocation?.description {
                Text(description)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }

            if let imageName = randomlocation?.name {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .padding()
            }

            HStack(spacing: 12) {
                if let lastLocation = locationManager.lastLocation,
                   let randomlocation = randomlocation {
                    let locationDistance = distance(location1: randomlocation, location2: lastLocation)
                    Text("\(locationDistance) km away")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    if let temp = temperature {
                        Image(systemName: weatherIcon)
                            .foregroundColor(.yellow)
                        Text("\(Int(temp))°C")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .onAppear {
                if let location = randomlocation {
                    weatherManager.fetchWeather(latitude: location.latitude, longitude: location.longitude) { temp, icon in
                        self.temperature = temp
                        self.weatherIcon = icon
                    }
                }
            }

            Spacer()

            Button(action: {
                selectedTab = 0
                selectedLocationTip = randomlocation
            }) {
                Text("Watch on Map")
                    .fontWeight(.medium)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding()
    }
}
