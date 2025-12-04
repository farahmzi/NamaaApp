import SwiftUI

enum AppGradient {
    // Core 4-stop background gradient used across screens
    static var primary: LinearGradient {
        LinearGradient(
            colors: [
                Color(red: 130/255, green: 180/255, blue: 240/255),
                Color(red: 200/255, green: 230/255, blue: 250/255),
                Color(red: 255/255, green: 250/255, blue: 200/255),
                Color(red: 255/255, green: 220/255, blue: 100/255)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    // Same gradient with a subtle dark overlay for text legibility on light areas
    static func primaryWithOverlay(opacity: Double = 0.22) -> some View {
        ZStack {
            primary
            Color.black.opacity(opacity)
        }
    }

    // Blue → Yellow button gradient matching the palette
    static var button: LinearGradient {
        LinearGradient(
            colors: [Color.appBlue, Color.appYellow],
            startPoint: .leading,
            endPoint: .trailing
        )
    }
}
