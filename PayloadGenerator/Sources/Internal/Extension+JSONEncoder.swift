import Foundation

extension JSONEncoder {
    static func pushDecoder(debug: Bool) -> JSONEncoder {
        let decoder = JSONEncoder()
        if debug {
            decoder.dateEncodingStrategy = .iso8601
        } else {
            // This is important to ensure
            // LiveActivities work well with the dates
            // passed to the console
            decoder.dateEncodingStrategy = .secondsSince1970
        }
        return decoder
    }
}
