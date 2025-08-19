import SwiftUI
import LiveActivityData

enum Palette {
    enum Brand {
        static let accent = Color("AccentColor")
        static let checkinAvailable = Color("CheckinAvailable")
        static let boarding = Color("Boarding")
        // Centralize the previously hard-coded RGB color:
        static let flightInfoPill = Color(red: 4/255, green: 79/255, blue: 135/255)
    }
}

public struct ExtraView: View {
    let flightState: FlightActivityAttributes.FlightState
    @Environment(\.activityFamily) private var activityFamily

    private var isAppleWatch: Bool { activityFamily == .small }
    private var pillMaxHeight: CGFloat { isAppleWatch ? 15 : 30 }
    private var labelFont: Font { isAppleWatch ? .caption.smallCaps() : .headline.weight(.bold) }

    public init(flightState: FlightActivityAttributes.FlightState) {
        self.flightState = flightState
    }

    public var body: some View {
        switch flightState {
        case .booked(let freeSeats):
            if let freeSeats {
                pill("\(freeSeats)% Seats available",
                     color: Palette.Brand.flightInfoPill)
            }
        case .checkinAvailable:
            pill("Checkin available!",
                 color: Palette.Brand.checkinAvailable)
        case .boarding:
            pill("BOARDING!",
                 color: Palette.Brand.boarding)
        case .landed:
            pill("Landed",
                 color: Palette.Brand.accent)
        }
    }

    // MARK: - UI

    @ViewBuilder
    private func pill(_ text: String, color: Color) -> some View {
        HStack(alignment: .top) {
            Text(text)
                .font(labelFont)
        }
        .padding(.horizontal)
        .background(
            Capsule()
                .fill(color)
                .frame(maxHeight: pillMaxHeight)
        )
    }
}
