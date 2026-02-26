import SwiftUI

// MARK: - Individual reusable pattern components

//── ◆ ── divider line
struct DiamondDivider: View {
    var color: Color = Color("Moss")

    var body: some View {
        HStack {
            Rectangle()
                .fill(color.opacity(0.6))
                .frame(height: 1)
            Text("◆")
                .font(.system(.caption2))
                .foregroundColor(color)
            Rectangle()
                .fill(color.opacity(0.6))
                .frame(height: 1)
        }
        .accessibilityHidden(true)
    }
}

// ── ∎ ── divider line
struct SquareDivider: View {
    var color: Color = Color("Moss")

    var body: some View {
        HStack {
            Rectangle()
                .fill(color.opacity(0.6))
                .frame(height: 1)
            Text("∎")
                .font(.system(.caption2))
                .foregroundColor(color)
            Rectangle()
                .fill(color.opacity(0.6))
                .frame(height: 1)
        }
        .accessibilityHidden(true)
    }
}

// Row of small filled dots
struct DotRow: View {
    var color: Color = Color("Moss")
    var count: Int = 9
    var dotSize: CGFloat = 3

    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<count, id: \.self) { _ in
                Circle()
                    .fill(color.opacity(0.6))
                    .frame(width: dotSize, height: dotSize)
            }
        }
        .accessibilityHidden(true)
    }
}

//Row of vertical rectangle bars (ornament)
struct BarRow: View {
    var color: Color = Color("Moss")
    var count: Int = 7

    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<count, id: \.self) { _ in
                Rectangle()
                    .fill(color.opacity(0.7))
                    .frame(width: 3, height: 12)
            }
        }
        .accessibilityHidden(true)
    }
}

// Row of chevron.right symbols
struct ChevronRow: View {
    var color: Color = Color("Moss")
    var count: Int = 10

    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<count, id: \.self) { _ in
                Image(systemName: "chevron.right")
                    .font(.system(.caption2).weight(.bold))
                    .foregroundColor(color)
            }
        }
        .accessibilityHidden(true)
    }
}

// Ascending bar chart ornament
struct AscendingBars: View {
    var color: Color = Color("Moss")
    var count: Int = 6

    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<count, id: \.self) { i in
                Rectangle()
                    .fill(color.opacity(0.7))
                    .frame(width: 6, height: CGFloat(6 + i * 2))
            }
        }
        .accessibilityHidden(true)
    }
}

// MARK: - AppPattern

struct AppPattern: View {
    var color: Color = Color("Moss")

    var body: some View {
        VStack(spacing: 20) {
            DiamondDivider(color: color)
                .padding(.horizontal, 50)

            DotRow(color: color)

            BarRow(color: color)
                .padding(.top, 5)

            SquareDivider(color: color)

            ChevronRow(color: color)

            AscendingBars(color: color)
        }
        .padding()
        .accessibilityHidden(true)
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: 40) {
        AppPattern(color: Color("Moss"))
        AppPattern(color: Color("Gold"))
        AppPattern(color: Color("Red3"))
    }
    .padding()
    .background(Color("Beige3"))
}
