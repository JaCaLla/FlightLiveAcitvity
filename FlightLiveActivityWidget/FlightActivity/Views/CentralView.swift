import SwiftUI
import LiveActivityData

public struct CentralView: View, @preconcurrency Equatable {

    let departure: FlightActivityAttributes.Departure
    let flightState: FlightActivityAttributes.FlightState
    let isWidget: Bool
    
    @Environment(\.activityFamily) var activityFamily
    var isAppleWatch: Bool { activityFamily == .small }

    
    public init(departure: FlightActivityAttributes.Departure,
                flightState: FlightActivityAttributes.FlightState,
                isWidget: Bool = false) {
        self.departure = departure
        self.flightState = flightState
        self.isWidget = isWidget
    }

    public var body: some View {
        if case .landed(_) = flightState , !isAppleWatch  {
            HStack {
                if isWidget { Spacer() }
                Image(systemName: "airplane.arrival")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40)
                if isWidget { Spacer() }
            }
        } else {
            HStack {
                if !isAppleWatch  {
                    Image(systemName: "airplane.departure")
                }
                Text(departure.dateTime.toDDMMAAHHMM())
                    .font(isAppleWatch ? .caption.bold() : .callout.bold())
            }//.frame(height: 40)
        }
    }
    
    // MARk :- Equatable
    @MainActor
    public static func == (lhs: CentralView, rhs: CentralView) -> Bool {
        lhs.departure == rhs.departure &&
        lhs.flightState == rhs.flightState &&
        lhs.isWidget == rhs.isWidget
    }
    
}
