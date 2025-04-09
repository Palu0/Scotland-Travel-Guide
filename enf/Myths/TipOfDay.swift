//
//  myths.swift
//  enf
//
//  Created by Nicolas Fuchs on 21.03.25.
//
import SwiftUI
import CoreLocation
var randomlocation : Location? = locations.randomElement()
var selectedLocationTip : Location?
struct TipOfDay: View {
    @StateObject var locationManager = LocationManager()
    @Binding var selectedTab: Int
    public var body: some View {
        
        VStack{
            Text("Your Tip of the Day!")
                .font(.headline)
            HStack{
                Text("Let's visit \(randomlocation?.name ?? "No locations available")")
                    .font(.title)
                Image(systemName: "\(randomlocation?.symbol ?? "marker")")
            }
            Spacer()
            Text("\(randomlocation?.description ?? "No locations available")")
            Spacer()
            Image("\(randomlocation?.name ?? "No locations available")")
                .resizable()
                .scaledToFit()
            if let lastlocation = locationManager.lastLocation {
                if let randomlocation = randomlocation{
                    let Locationdistance = distance(location1:randomlocation, location2: lastlocation)
                    Text("You are only \(Locationdistance)km away")
                }
            }
            
            Spacer()
                Button("Watch on Map") {
                    selectedTab = 0
                    selectedLocationTip = randomlocation
                }
            }
        }
    }

