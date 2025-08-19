import SwiftUI
import LiveActivityData

public struct CompactTrailingView: View, Equatable {
    public let flightNumber: String
    public let flightState: FlightActivityAttributes.FlightState

    public init(
        flightNumber: String,
        flightState: FlightActivityAttributes.FlightState
    ) {
        self.flightNumber = flightNumber
        self.flightState = flightState
    }

    public var body: some View {
        content
            .lineLimit(1)
            .minimumScaleFactor(0.85)
    }

    // MARK: - Content

    @ViewBuilder
    private var content: some View {
        switch flightState {
        case .booked(let seats):
            bookedView(seats)

        case .checkinAvailable:
            ExtraView(flightState: flightState)
            
        case .boarding(let gate):
            Text("Gate: \(gate)")
                .font(.caption).bold()

        case .landed(let belt):
            HStack(spacing: 6) {
                Image(systemName: "airplane.arrival")
                Image(systemName: "bag")
                Text(belt)
                    .font(.caption)
            }
            .accessibilityLabel("Baggage belt \(belt)")
        }
    }

    @ViewBuilder
    private func bookedView(_ seats: Int?) -> some View {
        if let seats {
            HStack(spacing: 6) {
                Image(systemName: "figure.seated.side.right.airbag.on")
                Text("\(seats)% Free")
                    .font(.caption)
            }
            .accessibilityLabel("\(seats) percent seats free")
        } else {
            Text(flightNumber)
                .font(.caption)
                .monospacedDigit()
                .accessibilityLabel("Flight \(flightNumber)")
        }
    }
}
