import ActivityKit
import Foundation
import LiveActivityData
import SwiftUI
import WidgetKit

struct BookingFlightLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: FlightActivityAttributes.self) { context in
            let attrs = context.attributes
            let state = context.state

            FlightWidgetView(attrs: attrs, state: state)

        } dynamicIsland: { context in
            let journey = context.attributes.journey
            let state = context.state

            return DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    OriginView(
                        imageName: journey.imageName,
                        origin: journey.origin,
                        departure: state.departure,
                        flightState: state.flightState
                    )
                }

                DynamicIslandExpandedRegion(.trailing) {
                    DestinationView(
                        flightNumber: journey.flightNumber,
                        destination: journey.destination,
                        arrivalDateTime: state.arrivalDateTime,
                        flightState: state.flightState
                    )
                }

                DynamicIslandExpandedRegion(.center) {
                    CentralView(
                        departure: state.departure,
                        flightState: state.flightState
                    )
                }

                DynamicIslandExpandedRegion(.bottom) {
                    ExtraView(flightState: state.flightState)
                }
            } compactLeading: {
                CompactLeadingView(
                    origin: journey.origin,
                    destination: journey.destination,
                    flightNumber: journey.flightNumber,
                    flightState: state.flightState
                )
            } compactTrailing: {
                CompactTrailingView(
                    flightNumber: journey.flightNumber,
                    flightState: state.flightState
                )
            } minimal: {
                MinimalView()
            }
        }
        .supplementalActivityFamilies([.small, .medium])
    }
}

#Preview("Dynamic Island Compact", as: .content, using: FlightActivityAttributes.bookingActivity) {
    BookingFlightLiveActivity()
} contentStates: {
    FlightActivityAttributes.ContentState.booking
    FlightActivityAttributes.ContentState.booking30Free
    FlightActivityAttributes.ContentState.checkinAvailable
    FlightActivityAttributes.ContentState.boarding
    FlightActivityAttributes.ContentState.landed
}
