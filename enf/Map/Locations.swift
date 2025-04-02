import SwiftUI
import MapKit
import CoreLocation

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    let color: Color
    var description: String?
    var symbol: String?
    var radius: Double?
}

let locations: [Location] = [
    Location(name: "Highland Games", latitude: 56.8169, longitude: -5.1128, color: .red, description: "UWUWUWUWUUWUWUWUWUWWUWUUWUWWUWUW"),
    Location(name: "Edinburgh Fringe Festival", latitude: 55.9533, longitude: -3.1883, color: .red),
    Location(name: "Tall Ships Races", latitude: 57.1499, longitude: -2.0938, color: .red),
    Location(name: "Loch Ness", latitude: 57.3229, longitude: -4.4244, color: .blue, radius: 0.5),
    Location(name: "Arthur's Seat", latitude: 55.9445, longitude: -3.1618, color: .blue),
    Location(name: "Palace of Holyroodhouse", latitude: 55.9525, longitude: -3.1725, color: .green),
    Location(name: "Dunnottar Castle", latitude: 56.9450, longitude: -2.1970, color: .green),
    Location(name: "Loch Ness Monster", latitude: 57.3229, longitude: -4.4244, color: .purple),
    Location(name: "Fingal's Cave", latitude: 56.4337, longitude: -6.3350, color: .purple, symbol: "mountain.2.fill")
]

