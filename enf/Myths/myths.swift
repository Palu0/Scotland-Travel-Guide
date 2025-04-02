//
//  myths.swift
//  enf
//
//  Created by Nicolas Fuchs on 21.03.25.
//
import SwiftUI

var randomlocation : String = ""

struct myths: View {
    public var body: some View {
        VStack{
            Text("Your Tip of the Day!")
                .font(.headline)
            Button("Get your Tip of the Day") {
                
            }
            Text("Let's visit \(locations.randomElement()?.name ?? "No locations available")")
        }
    }
}
