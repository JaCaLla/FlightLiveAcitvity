import Foundation
import SwiftUI
import WidgetKit

#if canImport(ActivityKit)
    import ActivityKit

    extension FlightActivityAttributes: ActivityAttributes {}
#endif

public struct FlightActivityAttributes: Codable, Sendable {
    public let journey: Journey
    
    public struct ContentState: Codable, Hashable, Sendable {
        public let flightState: FlightState
        public let departure: Departure
        public let arrivalDateTime: Date
    }
    
    public enum FlightState: Codable, Hashable, Sendable, Equatable {
        case booked(freeSeats: Int? = nil)
        case checkinAvailable
        case boarding(gate: String)
        case landed(belt: String)
    }
    
    public struct Departure: Codable, Hashable, Sendable, Equatable {
        public let dateTime: Date
        public let terminal: String
    }

    public struct Journey: Codable, Hashable, Sendable {
        public let imageName: String
        public let flightNumber: String
        public let origin: String
        public let destination: String
    }
}

