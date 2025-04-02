//
//  myths.swift
//  enf
//
//  Created by Nicolas Fuchs on 21.03.25.
//
import SwiftUI

var randomlocation : Location? = locations.randomElement()

struct TipOfDay: View {
    public var body: some View {
        VStack{
            Text("Your Tip of the Day!")
                .font(.headline)
            
            Text("Let's visit \(randomlocation?.name ?? "No locations available")")
                .font(.title)
            Text("\(randomlocation?.description ?? "No locations available")")
            
            }
        }
    }

