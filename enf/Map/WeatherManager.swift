//
//  WeatherManager.swift
//  enf
//
//  Created by Paul Gehring on 09.04.25.
//


import Foundation
import CoreLocation
import SwiftUI

class WeatherManager: ObservableObject {
    static let shared = WeatherManager()
    
    @Published var temperature: Double?
    @Published var weatherIcon: String = "questionmark.circle"

    // Fetch weather by coordinates
    func fetchWeather(latitude: Double, longitude: Double, completion: @escaping (Double?, String) -> Void) {
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&current_weather=true"
        guard let url = URL(string: urlString) else {
            completion(nil, "questionmark.circle")
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil, "questionmark.circle")
                return
            }

            do {
                let decoded = try JSONDecoder().decode(OpenMeteoResponse.self, from: data)
                let temperature = decoded.current_weather.temperature
                let icon = self.mapWeatherCodeToIcon(code: decoded.current_weather.weathercode)

                DispatchQueue.main.async {
                    self.temperature = temperature
                    self.weatherIcon = icon
                    completion(temperature, icon)
                }
            } catch {
                print("Failed to decode weather: \(error)")
                completion(nil, "questionmark.circle")
            }
        }.resume()
    }

    // Weather Code → SF Symbol
    private func mapWeatherCodeToIcon(code: Int) -> String {
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

// MARK: - API Model
struct OpenMeteoResponse: Codable {
    let current_weather: WeatherData

    struct WeatherData: Codable {
        let temperature: Double
        let weathercode: Int
    }
}
