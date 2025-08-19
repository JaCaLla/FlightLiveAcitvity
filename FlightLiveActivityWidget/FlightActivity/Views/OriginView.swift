import SwiftUI
import LiveActivityData

public struct OriginView: View {
    let imageName: String
    let origin: String
    let departure: FlightActivityAttributes.Departure
    let flightState: FlightActivityAttributes.FlightState

    @Environment(\.activityFamily) var activityFamily
    var isAppleWatch: Bool { activityFamily == .small }

    public init(imageName: String,
                origin: String,
                departure: FlightActivityAttributes.Departure,
                flightState: FlightActivityAttributes.FlightState) {
        self.imageName = imageName
        self.origin = origin
        self.departure = departure
        self.flightState = flightState
    }

    var imageSize: CGFloat { activityFamily == .small ? 40 : 66 }

    public var body: some View {
        VStack(alignment: .leading, spacing: -5) {
            if activityFamily != .small {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 35)
            }

            Text(origin)
                .font(isAppleWatch ? .body.bold() :.largeTitle.bold())
            HStack {
                Text(departure.terminal)
                if case .boarding(let gate) = flightState {
                    Text("Gate: \(gate)")
                }
            }
            .font(isAppleWatch ? .body.bold() :.subheadline.bold())

        }
    }
}
