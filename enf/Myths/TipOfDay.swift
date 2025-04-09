//
//  myths.swift
//  enf
//
//  Created by Nicolas Fuchs on 21.03.25.
//
import SwiftUI
import CoreLocation

var randomlocation: Location? = locations.randomElement()
var selectedLocationTip: Location?

struct TipOfDay: View {
    @StateObject var locationManager = LocationManager()
    @Binding var selectedTab: Int

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

            if let lastLocation = locationManager.lastLocation,
               let randomlocation = randomlocation {
                let locationDistance = distance(location1: randomlocation, location2: lastLocation)
                Text("You are only \(locationDistance) km away")
                    .font(.subheadline)
                    .foregroundColor(.gray)
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
