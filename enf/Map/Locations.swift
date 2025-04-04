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
    var distance: Double?
}

let locations: [Location] = [
    // 🔴 Events
    Location(name: "Highland Games", latitude: 56.8169, longitude: -5.1128, color: .red),
    Location(name: "Edinburgh Fringe Festival", latitude: 55.9533, longitude: -3.1883, color: .red),
    Location(name: "Tall Ships Races", latitude: 57.1499, longitude: -2.0938, color: .red),
    Location(name: "Beltane Fire Festival", latitude: 55.9533, longitude: -3.1883, color: .red),
    Location(name: "Royal Edinburgh Military Tattoo", latitude: 55.9486, longitude: -3.1999, color: .red),
    Location(name: "Edinburgh International Festival", latitude: 55.9533, longitude: -3.1883, color: .red),
    Location(name: "Samhuinn Fire Festival", latitude: 55.9533, longitude: -3.1883, color: .red),
    Location(name: "Glasgow Whisky Festival", latitude: 55.8642, longitude: -4.2518, color: .red),
    Location(name: "Edinburgh Hogmanay", latitude: 55.9533, longitude: -3.1883, color: .red),
    Location(name: "Edinburgh International Science Festival", latitude: 55.9510, longitude: -3.1910, color: .red),
    Location(name: "Glasgow International Comedy Festival", latitude: 55.8642, longitude: -4.2518, color: .red),
    Location(name: "St Andrew's Day", latitude: 56.4907, longitude: -2.8013, color: .red),
    Location(name: "Slamdunk Festival", latitude: 55.8625, longitude: -4.2518, color: .red),
    Location(name: "The Scottish Open", latitude: 56.1141, longitude: -3.9466, color: .red),
    Location(name: "Tartan Day Parade", latitude: 55.8650, longitude: -4.2570, color: .red),
    Location(name: "Burns Night", latitude: 55.8781, longitude: -4.3100, color: .red),
    Location(name: "Scottish Borders Walking Festival", latitude: 55.7075, longitude: -2.7710, color: .red),
    Location(name: "Isle of Islay Festival of Music and Malt", latitude: 55.6742, longitude: -6.1100, color: .red),


    // 🔵 Points of Interest (POI)
    Location(name: "Highland Games", latitude: 57.3229, longitude: -4.4244, color: .blue),
    Location(name: "Edinburgh Castle", latitude: 55.9486, longitude: -3.1999, color: .blue),
    Location(name: "Arthur's Seat", latitude: 55.9445, longitude: -3.1618, color: .blue),
    Location(name: "Kelvingrove Art Gallery and Museum", latitude: 55.8680, longitude: -4.2906, color: .blue),
    Location(name: "The Real Mary King's Close", latitude: 55.9508, longitude: -3.1901, color: .blue),
    Location(name: "Celtic Park", latitude: 55.8497, longitude: -4.2055, color: .blue),
    Location(name: "Culloden Battlefield", latitude: 57.4765, longitude: -4.0918, color: .blue),
    Location(name: "Fairy Pools", latitude: 57.2500, longitude: -6.2720, color: .blue),
    Location(name: "Scott Monument", latitude: 55.9531, longitude: -3.1937, color: .blue),
    Location(name: "Greyfriars Bobby", latitude: 55.9471, longitude: -3.1910, color: .blue),
    Location(name: "Ibrox Stadium", latitude: 55.8520, longitude: -4.3090, color: .blue),
    Location(name: "Forth Bridge", latitude: 56.0000, longitude: -3.4000, color: .blue),
    Location(name: "George Square", latitude: 55.8611, longitude: -4.2500, color: .blue),
    Location(name: "Commando Monument", latitude: 56.8887, longitude: -4.9194, color: .blue),

    
    // 🟢 History
    Location(name: "Palace of Holyroodhouse", latitude: 55.9525, longitude: -3.1725, color: .green),
    Location(name: "Dunnottar Castle", latitude: 56.9450, longitude: -2.1970, color: .green),
    Location(name: "Urquhart Castle", latitude: 57.3240, longitude: -4.4400, color: .green),
    Location(name: "St Giles' Cathedral", latitude: 55.9499, longitude: -3.1900, color: .green),
    Location(name: "Fort George", latitude: 57.5786, longitude: -4.0417, color: .green),
    Location(name: "Rosslyn Chapel", latitude: 55.8555, longitude: -3.1611, color: .green),
    Location(name: "Balmoral Castle", latitude: 57.0406, longitude: -3.2305, color: .green),
    Location(name: "National Wallace Monument", latitude: 56.1289, longitude: -3.9375, color: .green),
    Location(name: "Linlithgow Palace", latitude: 55.9764, longitude: -3.6000, color: .green),
    Location(name: "Culzean Castle & Country Park", latitude: 55.3565, longitude: -4.8104, color: .green),
    Location(name: "Stirling Castle", latitude: 56.1224, longitude: -3.9461, color: .green),
    Location(name: "Glamis Castle", latitude: 56.6225, longitude: -3.0047, color: .green),
    Location(name: "Craigmillar Castle", latitude: 55.9231, longitude: -3.1314, color: .green),
    
    // 🔷 Myths & Legends
    Location(name: "Loch Ness", latitude: 57.3229, longitude: -4.4244, color: .purple),
    Location(name: "Selkies - Orkney Islands", latitude: 58.9825, longitude: -2.9595, color: .purple),
    Location(name: "Fingal's Cave", latitude: 56.4337, longitude: -6.3350, color: .purple),
    Location(name: "Corryvreckan Whirlpool", latitude: 56.1833, longitude: -5.7333, color: .purple),
    Location(name: "Nine Maidens of Dundee", latitude: 56.4870, longitude: -3.0041, color: .purple),
    Location(name: "Stoor Worm - Orkney", latitude: 58.9825, longitude: -2.9595, color: .purple),
    Location(name: "Gorbals Vampire - Glasgow", latitude: 55.8460, longitude: -4.2580, color: .purple),
    Location(name: "Ghost Piper of Clanyard Bay", latitude: 54.7000, longitude: -4.9500, color: .purple),
    Location(name: "Robert the Bruce and the Spider - Bruce’s Cave", latitude: 55.0240, longitude: -3.0780, color: .purple),
    Location(name: "The Ghosts of Glamis Castle", latitude: 56.6225, longitude: -3.0003, color: .purple),
    Location(name: "The Green Lady of Crathes Castle", latitude: 57.0671, longitude: -2.4886, color: .purple),
    Location(name: "The White Lady of St Andrews Cathedral", latitude: 56.3395, longitude: -2.7969, color: .purple),
    Location(name: "The Mermaid of Assynt", latitude: 58.1700, longitude: -5.1000, color: .purple)

]
