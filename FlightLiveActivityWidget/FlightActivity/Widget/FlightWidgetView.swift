import LiveActivityData
import SwiftUI

public struct FlightWidgetView: View {
    var attrs: FlightActivityAttributes
    var state: FlightActivityAttributes.ContentState

    @Environment(\.activityFamily) var activityFamily
    var isAppleWatch: Bool { activityFamily == .small }

    public init(attrs: FlightActivityAttributes, state: FlightActivityAttributes.ContentState) {
        self.attrs = attrs
        self.state = state
    }

    public var body: some View {
        VStack(spacing: -10){
            HStack(spacing: 18) {
                OriginView(imageName: attrs.journey.imageName,
                           origin: attrs.journey.origin,
                           departure: state.departure,
                           flightState: state.flightState)
                CentralView(departure: state.departure,
                            flightState: state.flightState,
                            isWidget: true)
                DestinationView(flightNumber: attrs.journey.flightNumber,
                                destination: attrs.journey.destination,
                                arrivalDateTime: state.arrivalDateTime,
                                flightState: state.flightState)
            }
            ExtraView(flightState: state.flightState)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .foregroundStyle(.white)
        .background(BackgroundGradient())
    }
}

