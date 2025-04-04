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
    Location(name: "Highland Games", latitude: 56.8169, longitude: -5.1128, color: .red, description: "A traditional celebration of Scottish culture featuring strength events like caber tossing and hammer throwing, along with piping and Highland dancing, held across Scotland."),
    Location(name: "Edinburgh Fringe Festival", latitude: 55.9533, longitude: -3.1883, color: .red, description: "The world’s largest arts festival, with thousands of performances in theater, comedy, and music, transforming Edinburgh into a creative hub."),
    Location(name: "Tall Ships Races", latitude: 57.1499, longitude: -2.0938, color: .red, description: "An international sailing event where large traditional ships gather in Scottish ports. Visitors can see the vessels up close, explore some onboard, and experience related maritime events and activities."),
    Location(name: "Beltane Fire Festival", latitude: 55.9533, longitude: -3.1883, color: .red, description: "A modern revival of an ancient Celtic celebration marking the arrival of summer. Held on Calton Hill in Edinburgh, it features fire displays, drumming, and performances inspired by folklore and mythology."),
    Location(name: "Royal Edinburgh Military Tattoo", latitude: 55.9496, longitude: -3.1999, color: .red, description: "A renowned military spectacle held at Edinburgh Castle, featuring performances by Scottish regiments, marching bands, and international acts, all set against the stunning backdrop of the castle."),
    Location(name: "Edinburgh International Festival", latitude: 55.9533, longitude: -3.1889, color: .red, description: "A world-class celebration of the arts, featuring opera, theater, classical music, and dance performances from top artists and companies, held annually in Edinburgh."),
    Location(name: "Samhuinn Fire Festival", latitude: 55.9543, longitude: -3.1883, color: .red, description: "A dramatic reenactment of ancient Celtic rituals marking the transition from summer to winter. Held on Calton Hill in Edinburgh, it combines fire displays, dance, and storytelling based on Scottish folklore."),
    Location(name: "Glasgow Whisky Festival", latitude: 55.8652, longitude: -4.2518, color: .red, description: "A celebration of Scotland’s national drink, featuring tastings from top distilleries, masterclasses, and expert-led sessions. It’s a must-visit for whisky enthusiasts looking to explore a variety of blends and single malts."),
    Location(name: "Edinburgh Hogmanay", latitude: 55.9533, longitude: -3.1883, color: .red, description: "Scotland’s famous New Year celebration, featuring a massive street party, live music, a torchlight procession, and a spectacular fireworks display over Edinburgh Castle to ring in the new year."),
    Location(name: "Edinburgh International Science Festival", latitude: 55.9510, longitude: -3.1910, color: .red, description: "A celebration of science and innovation with interactive exhibits, workshops, and talks. It brings together experts and visitors of all ages to explore the wonders of science in engaging and fun ways."),
    Location(name: "Glasgow International Comedy Festival", latitude: 55.8642, longitude: -4.2518, color: .red, description: "Scotland’s largest comedy festival, featuring performances from top comedians and emerging talent. It offers a mix of stand-up, improv, and theatrical comedy across various venues in Glasgow."),
    Location(name: "St Andrew's Day", latitude: 56.4907, longitude: -2.8013, color: .red, description: "Scotland’s national day, celebrated on November 30th in honor of Saint Andrew. It features traditional music, Scottish cuisine, and cultural events across the country, marking Scotland's heritage and pride."),
    Location(name: "Slamdunk Festival", latitude: 55.8625, longitude: -4.2518, color: .red, description: "A popular UK music festival featuring top punk, rock, and alternative bands. Held in multiple cities, it’s known for its high-energy performances and vibrant atmosphere, attracting music fans from all over."),
    Location(name: "The Scottish Open", latitude: 56.1141, longitude: -3.9466, color: .red, description: "A prestigious golf tournament held annually in Scotland, attracting top international players. It’s part of the European Tour and offers a chance to see world-class golf against the backdrop of Scotland's scenic courses."),
    Location(name: "Tartan Day Parade", latitude: 55.8650, longitude: -4.2570, color: .red, description: "A celebration of Scottish heritage, held annually in various cities, with the largest in New York. The parade features bagpipers, dancers, and pipers, all proudly showcasing Scotland's iconic tartan and culture."),
    Location(name: "Burns Night", latitude: 55.8781, longitude: -4.3100, color: .red, description: "A celebration of Scotland’s national poet, Robert Burns, held on January 25th. It includes reciting his poetry, enjoying traditional Scottish dishes like haggis, and toasting with whisky in his honor."),
    Location(name: "Scottish Borders Walking Festival", latitude: 55.7075, longitude: -2.7710, color: .red, description: "An annual event celebrating the region's stunning landscapes. It offers guided walks through picturesque hills, valleys, and historic sites, perfect for nature lovers and hiking enthusiasts."),
    Location(name: "Isle of Islay Festival of Music and Malt", latitude: 55.6742, longitude: -6.1100, color: .red, description: "A week-long celebration of Islay’s whisky heritage and vibrant music scene. The festival features distillery tours, whisky tastings, live performances, and a lively atmosphere across the island."),


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
