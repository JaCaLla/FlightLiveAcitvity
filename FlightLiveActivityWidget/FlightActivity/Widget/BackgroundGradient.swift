import LiveActivityData
import SwiftUI

struct BackgroundGradient: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [
                    Color(red: 0, green: 0, blue: 0),
                    Color(Palette.Brand.accent),
                ]
            ),
            startPoint: .bottomLeading,
            endPoint: .topTrailing
        )
    }
}
