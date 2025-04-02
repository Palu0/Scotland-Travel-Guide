import SwiftUI

struct LocationPopupView: View {
    let location: Location
    let onClose: () -> Void

    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(location.name)
                        .font(.headline)
                    Spacer()
                    Button(action: onClose) {
                        Image(systemName: "xmark.circle")
                    }
                }
                Text(location.description ?? "No description available.")
                    .font(.subheadline)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .shadow(radius: 5)
        }
        .offset(y: +10)
    }
}
