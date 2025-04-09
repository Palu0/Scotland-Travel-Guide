//
//  myths.swift
//  enf
//
//  Created by Nicolas Fuchs on 21.03.25.
//
import SwiftUI
import CoreLocation
var randomlocation : Location? = locations.randomElement()

struct TipOfDay: View {
    @StateObject var locationManager = LocationManager()
    @State var selectedLocation: Location?
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
                    var Locationdistance = distance(location1:randomlocation, location2: lastlocation ?? CLLocation(latitude: 0, longitude: 0))
                    Text("You are only \(Locationdistance ?? 0)km away")
                }
            }
            
            Spacer()
            Button("watch on Map") {
                selectedLocation = randomlocation
                
            }
            if let selectedLocation = selectedLocation {
                LocationPopupView(location : selectedLocation){
                    self.selectedLocation = nil
                }
            }
        }
    }
}

