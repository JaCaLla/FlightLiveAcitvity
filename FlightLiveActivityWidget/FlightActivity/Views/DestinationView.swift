import LiveActivityData
import SwiftUI

public struct DestinationView: View {
    let flightNumber: String
    let destination: String
    let arrivalDateTime: Date
    let flightState: FlightActivityAttributes.FlightState

    @Environment(\.activityFamily) var activityFamily
    var isAppleWatch: Bool { activityFamily == .small }

    public init(flightNumber: String,
                destination: String,
                arrivalDateTime: Date,
                flightState: FlightActivityAttributes.FlightState) {
        self.flightNumber = flightNumber
        self.destination = destination
        self.arrivalDateTime = arrivalDateTime
        self.flightState = flightState
    }

    var imageSize: CGFloat { activityFamily == .small ? 40 : 66 }

    public var body: some View {
        VStack(alignment: .trailing,spacing: -5) {
            Text(flightNumber)
                .font( isAppleWatch ? .caption : .title3.bold())
                .frame(height: 35)

            Text(destination)
                .font( isAppleWatch ? .body.bold() : .largeTitle.bold())
                if case .landed(let belt) = flightState {
                    Text("Bag claim: \(belt)")
                        .font(isAppleWatch ? .body.bold() :.subheadline.bold())
                }
        }
    }
}
