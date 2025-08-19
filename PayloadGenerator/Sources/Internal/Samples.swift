import Foundation
import LiveActivityData

func bookedFlight(debug: Bool) throws -> String {
    let contentState = FlightActivityAttributes.ContentState.booking
    let push = PushPayload(
        aps: StartApsContent(
            contentState: contentState,
            attributesType: "FlightActivityAttributes",
            attributes: FlightActivityAttributes.bookingActivity
        )
    )
    let data = try JSONEncoder.pushDecoder(debug: debug).encode(push)
    return try data.prettyPrintedJSONString
}

func bookedFlight30Available(debug: Bool) throws -> String {
    let contentState = FlightActivityAttributes.ContentState.booking30Free
    let push = PushPayload(
        aps: StartApsContent(
            contentState: contentState,
            attributesType: "FlightActivityAttributes",
            attributes: FlightActivityAttributes.bookingActivity
        )
    )
    let data = try JSONEncoder.pushDecoder(debug: debug).encode(push)
    return try data.prettyPrintedJSONString
}

func checkinAvailable(debug: Bool) throws -> String {
    let contentState = FlightActivityAttributes.ContentState.checkinAvailable
    let push = PushPayload(
        aps: StartApsContent(
            contentState: contentState,
            attributesType: "FlightActivityAttributes",
            attributes: FlightActivityAttributes.bookingActivity
        )
    )
    let data = try JSONEncoder.pushDecoder(debug: debug).encode(push)
    return try data.prettyPrintedJSONString
}

func boarding(debug: Bool) throws -> String {
    let contentState = FlightActivityAttributes.ContentState.boarding
    let push = PushPayload(
        aps: StartApsContent(
            contentState: contentState,
            attributesType: "FlightActivityAttributes",
            attributes: FlightActivityAttributes.bookingActivity
        )
    )
    let data = try JSONEncoder.pushDecoder(debug: debug).encode(push)
    return try data.prettyPrintedJSONString
}

func landed(debug: Bool) throws -> String {
    let contentState = FlightActivityAttributes.ContentState.landed
    let push = PushPayload(
        aps: StartApsContent(
            contentState: contentState,
            attributesType: "FlightActivityAttributes",
            attributes: FlightActivityAttributes.bookingActivity
        )
    )
    let data = try JSONEncoder.pushDecoder(debug: debug).encode(push)
    return try data.prettyPrintedJSONString
}

