import SwiftUI

public struct MinimalView: View {
    private let width: CGFloat
    
    init(width: CGFloat = 40) {
        self.width = width
    }
    
    public var body: some View {
        Image("logox50")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width)
    }
}
