//
//  EventView.swift
//  enf
//
//  Created by Paul Gehring on 11.04.25.
//
import SwiftUI
import CoreLocation

struct EventView: View {
    let events: [Location]
    @Binding var selectedTab: Int

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(events) { event in
                    HStack(alignment: .top, spacing: 12) {
                        if let symbol = event.symbol {
                            Image(systemName: symbol)
                                .font(.title2)
                                .foregroundColor(event.color)
                        }

                        VStack(alignment: .leading, spacing: 6) {
                            Text(event.name)
                                .font(.headline)
                            if let description = event.description {
                                Text(description)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }

                        Spacer()
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .shadow(radius: 1)
                    .onTapGesture {
                        selectedTab = 0
                        selectedLocationTip = event
                    }
                }
            }
            .padding()
        }
    }
}
