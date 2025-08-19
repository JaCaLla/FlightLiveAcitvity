import Foundation

// MARK: - Samples for Journey

public extension FlightActivityAttributes.Journey {
    static let journey: Self = .init(
        imageName: "flyswift",
        flightNumber: "FSW-1234",
        origin: "BCN",
        destination: "DUB"
    )
}

// MARK: - Samples for Attributes

public extension FlightActivityAttributes {
    static let bookingActivity: Self = .init(journey: .journey)
}

// MARK: - Samples for ContentState

public extension FlightActivityAttributes.ContentState {

    // Tweak these if you want different demo timings.
    private static let departureOffsetHours: Int = 240   // 10 days from "now"
    private static let flightDurationHours: Int = 8

    private static func hoursFromNow(_ hours: Int, now: Date = .now) -> Date {
        Calendar.current.date(byAdding: .hour, value: hours, to: now) ?? now
    }

    private static var departureSample: FlightActivityAttributes.Departure {
        .init(
            dateTime: hoursFromNow(departureOffsetHours),
            terminal: "T1"
        )
    }

    private static var arrivalSample: Date {
        hoursFromNow(departureOffsetHours + flightDurationHours)
    }

    static let booking: Self = .init(
        flightState: .booked(),
        departure: departureSample,
        arrivalDateTime: arrivalSample
    )

    static let booking30Free: Self = .init(
        flightState: .booked(freeSeats: 30),
        departure: departureSample,
        arrivalDateTime: arrivalSample
    )

    static let checkinAvailable: Self = .init(
        flightState: .checkinAvailable,
        departure: departureSample,
        arrivalDateTime: arrivalSample
    )

    static let boarding: Self = .init(
        flightState: .boarding(gate: "G18"),
        departure: departureSample,
        arrivalDateTime: arrivalSample
    )

    static let landed: Self = .init(
        flightState: .landed(belt: "254"),
        departure: departureSample,
        arrivalDateTime: arrivalSample
    )
}
