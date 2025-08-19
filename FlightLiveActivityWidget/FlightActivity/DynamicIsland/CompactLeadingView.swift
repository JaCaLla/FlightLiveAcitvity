import SwiftUI
import LiveActivityData

public struct CompactLeadingView: View, Equatable {
    public let origin: String
    public let destination: String
    public let flightNumber: String
    public let flightState: FlightActivityAttributes.FlightState

    public var body: some View {
        HStack(spacing: 8) {
            Image("logox50")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .accessibilityHidden(true)

            Text(displayText)
                .font(.caption)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
    }
    
    private var displayText: String {
        switch flightState {
        case .booked(let freeSeats):
            return (freeSeats != nil) ? flightNumber : "\(origin)–\(destination)"
        case .checkinAvailable, .boarding, .landed:
            return flightNumber
        }
    }
}
