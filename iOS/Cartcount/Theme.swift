import SwiftUI

/// tomato red and citrus yellow, fresh-produce feel
enum Theme {
    static let accent = Color(red: 0.7765, green: 0.2824, blue: 0.1686)
    static let accentSecondary = Color(red: 0.9490, green: 0.7569, blue: 0.3059)
    static let background = Color(red: 0.0941, green: 0.0784, blue: 0.0627)
    static let cardBackground = background.opacity(0.6)

    static let titleFont = Font.system(.title2, design: .rounded).weight(.bold)
    static let headlineFont = Font.system(.headline, design: .rounded)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let captionFont = Font.system(.caption, design: .rounded)

    static let cornerRadius: CGFloat = 16
}
