import SwiftUI
import CoreLocation

struct EventView: View {
    let events: [Event]
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

                            if let days = event.daysUntilNextOccurrence() {
                                Text("in \(days) day\(days == 1 ? "" : "s")")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }

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
                    .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
                    .onTapGesture {
                        selectedTab = 0
                    }
                }
            }
            .padding()
        }
    }
}
