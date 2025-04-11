//
//  Events.swift
//  enf
//
//  Created by Paul Gehring on 11.04.25.
//
import SwiftUI
import MapKit
import CoreLocation

struct Event: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    let color: Color
    var description: String?
    var symbol: String?
    var distance: Double?
    var month: Int
    var day: Int
    
    // Returns the next Date this event will occur (this year or next)
    // Returns the next Date this event will occur (this year or next)
        func nextOccurrence(from date: Date = Date()) -> Date? {
            let calendar = Calendar.current
            let currentYear = calendar.component(.year, from: date)
            
            var thisYearComponents = DateComponents(year: currentYear, month: month, day: day)
            guard let thisYearDate = calendar.date(from: thisYearComponents) else {
                return nil
            }
            
            if thisYearDate >= date {
                return thisYearDate
            } else {
                var nextYearComponents = thisYearComponents
                nextYearComponents.year = currentYear + 1
                return calendar.date(from: nextYearComponents)
            }
        }
        
        // Returns the number of days until the next occurrence
        func daysUntilNextOccurrence(from date: Date = Date()) -> Int? {
            guard let nextDate = nextOccurrence(from: date) else { return nil }
            let calendar = Calendar.current
            let days = calendar.dateComponents([.day], from: date.startOfDay, to: nextDate.startOfDay).day
            return days
        }
    
}
extension Date {
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
}
let events: [Event] = [
    // 🔴 Events
    Event(name: "Highland Games", latitude: 56.8169, longitude: -5.1128, color: .red, description: "A traditional celebration of Scottish culture featuring strength events like caber tossing and hammer throwing, along with piping and Highland dancing, held across Scotland.", symbol: "figure.disc.sports", month: 8, day: 23),
    Event(name: "Edinburgh Fringe Festival", latitude: 55.9543, longitude: -3.1893, color: .red, description: "The world’s largest arts festival, with thousands of performances in theater, comedy, and music, transforming Edinburgh into a creative hub.", symbol: "theatermask.and.paintbrush.fill", month: 8, day: 9),
    Event(name: "Tall Ships Races", latitude: 57.1499, longitude: -2.0938, color: .red, description: "An international sailing event where large traditional ships gather in Scottish ports. Visitors can see the vessels up close, explore some onboard, and experience related maritime events and activities.", symbol: "sailboat.fill", month: 7, day: 27),
    Event(name: "Beltane Fire Festival", latitude: 55.9533, longitude: -3.1883, color: .red, description: "A modern revival of an ancient Celtic celebration marking the arrival of summer. Held on Calton Hill in Edinburgh, it features fire displays, drumming, and performances inspired by folklore and mythology.", symbol: "flame.fill", month: 4, day: 30),
    Event(name: "Royal Edinburgh Military Tattoo", latitude: 55.9496, longitude: -3.1999, color: .red, description: "A renowned military spectacle held at Edinburgh Castle, featuring performances by Scottish regiments, marching bands, and international acts, all set against the stunning backdrop of the castle.", symbol: "crown.fill", month: 8, day: 7),
    Event(name: "Edinburgh International Festival", latitude: 55.9533, longitude: -3.1889, color: .red, description: "A world-class celebration of the arts, featuring opera, theater, classical music, and dance performances from top artists and companies, held annually in Edinburgh.", symbol: "music.quarternote.3", month: 8, day: 7),
    Event(name: "Samhuinn Fire Festival", latitude: 55.9543, longitude: -3.1883, color: .red, description: "A dramatic reenactment of ancient Celtic rituals marking the transition from summer to winter. Held on Calton Hill in Edinburgh, it combines fire displays, dance, and storytelling based on Scottish folklore.", symbol: "flame.fill", month: 10, day: 31),
    Event(name: "Glasgow Whisky Festival", latitude: 55.8652, longitude: -4.2518, color: .red, description: "A celebration of Scotland’s national drink, featuring tastings from top distilleries, masterclasses, and expert-led sessions. It’s a must-visit for whisky enthusiasts looking to explore a variety of blends and single malts.", symbol: "wineglass.fill", month: 3, day: 14),
    Event(name: "Edinburgh Hogmanay", latitude: 55.9533, longitude: -3.1873, color: .red, description: "Scotland’s famous New Year celebration, featuring a massive street party, live music, a torchlight procession, and a spectacular fireworks display over Edinburgh Castle to ring in the new year.", symbol: "fireworks", month: 12, day: 31),
    Event(name: "Edinburgh International Science Festival", latitude: 55.9510, longitude: -3.1910, color: .red, description: "A celebration of science and innovation with interactive exhibits, workshops, and talks. It brings together experts and visitors of all ages to explore the wonders of science in engaging and fun ways.", symbol: "graduationcap.fill", month: 4, day: 4),
    Event(name: "Glasgow International Comedy Festival", latitude: 55.8642, longitude: -4.2518, color: .red, description: "Scotland’s largest comedy festival, featuring performances from top comedians and emerging talent. It offers a mix of stand-up, improv, and theatrical comedy across various venues in Glasgow.", symbol: "quote.bubble.fill", month: 3, day: 6),
    Event(name: "St Andrew's Day", latitude: 56.4907, longitude: -2.8013, color: .red, description: "Scotland’s national day, celebrated on November 30th in honor of Saint Andrew. It features traditional music, Scottish cuisine, and cultural events across the country, marking Scotland's heritage and pride.", symbol: "flag.fill", month: 11, day: 30),
    Event(name: "Slamdunk Festival", latitude: 55.8625, longitude: -4.2518, color: .red, description: "A popular UK music festival featuring top punk, rock, and alternative bands. Held in multiple cities, it’s known for its high-energy performances and vibrant atmosphere, attracting music fans from all over.", symbol: "music.quarternote.3", month: 5, day: 23),
    Event(name: "The Scottish Open", latitude: 56.1141, longitude: -3.9466, color: .red, description: "A prestigious golf tournament held annually in Scotland, attracting top international players. It’s part of the European Tour and offers a chance to see world-class golf against the backdrop of Scotland's scenic courses.", symbol: "figure.golf", month: 7, day: 13),
    Event(name: "Tartan Day Parade", latitude: 55.8650, longitude: -4.2570, color: .red, description: "A celebration of Scottish heritage, held annually in various cities, with the largest in New York. The parade features bagpipers, dancers, and pipers, all proudly showcasing Scotland's iconic tartan and culture.", symbol: "globe.europe.africa.fill", month: 4, day: 6),
    Event(name: "Burns Night", latitude: 55.8781, longitude: -4.3100, color: .red, description: "A celebration of Scotland’s national poet, Robert Burns, held on January 25th. It includes reciting his poetry, enjoying traditional Scottish dishes like haggis, and toasting with whisky in his honor.", symbol: "scroll.fill", month: 1, day: 25),
    Event(name: "Scottish Borders Walking Festival", latitude: 55.7075, longitude: -2.7710, color: .red, description: "An annual event celebrating the region's stunning landscapes. It offers guided walks through picturesque hills, valleys, and historic sites, perfect for nature lovers and hiking enthusiasts.", symbol: "figure.hiking", month: 6, day: 1),
    Event(name: "Isle of Islay Festival of Music and Malt", latitude: 55.6742, longitude: -6.1100, color: .red, description: "A week-long celebration of Islay’s whisky heritage and vibrant music scene. The festival features distillery tours, whisky tastings, live performances, and a lively atmosphere across the island.", symbol: "music.quarternote.3", month: 5, day: 23),
]
