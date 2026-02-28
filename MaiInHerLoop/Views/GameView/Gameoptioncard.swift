import SwiftUI

struct GameOptionCard: View {
    let text: String
    let isSelected: Bool
    let onSelect: () -> Void

    // MARK: - Responsive
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    private var isWide: Bool { horizontalSizeClass == .regular }

    var body: some View {
        Button(action: onSelect) {
            VStack(spacing: 0) {

                HStack {
                    Spacer()
                    HStack(spacing: 2) {
                        ForEach(0..<5, id: \.self) { _ in
                            Image(systemName: "chevron.right")
                                .font(.system(size: 4, weight: .bold))
                                .foregroundColor(isSelected ? Color("Beige").opacity(0.7) : Color("Moss").opacity(0.5))
                        }
                    }
                }
                .padding(.top, 8)
                .padding(.trailing, 10)

                Spacer(minLength: 4)

                Text(text)
                    .font(.system(isWide ? .subheadline : .caption, design: .monospaced).weight(.medium))
                    .foregroundColor(isSelected ? Color("Beige3") : Color("Beige"))
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 10)

                Spacer(minLength: 4)

                if isSelected {
                    Text("game.chosen".localized)
                        .font(.system(.caption2, design: .monospaced).weight(.black))
                        .foregroundColor(Color("Gold3"))
                        .tracking(1)
                        .padding(.bottom, 6)
                } else {
                    HStack(spacing: 3) {
                        Rectangle()
                            .fill(Color("Moss").opacity(0.5))
                            .frame(height: 1)
                        Text("◆")
                            .font(.system(size: 4))
                            .foregroundColor(Color("Moss").opacity(0.6))
                        Rectangle()
                            .fill(Color("Moss").opacity(0.5))
                            .frame(height: 1)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 8)
                }
            }
            .frame(maxWidth: .infinity, minHeight: isWide ? 100 : 80)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(isSelected ? Color("Moss") : Color("Gold3").opacity(0.9))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(
                        isSelected ? Color("Red3").opacity(0.6) : Color("Red3").opacity(0.5),
                        lineWidth: 1
                    )
            )
            .scaleEffect(isSelected ? 0.96 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: isSelected)
        }
        .buttonStyle(CardTapStyle())// handles the CardSelectModifier bounce on tap
        .accessibilityHint(isSelected ? "" : "game.option.hint".localized)
    }
}

// MARK: - Button style that applies CardSelectModifier 
private struct CardTapStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.92 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

#Preview {
    HStack(spacing: 12) {
        GameOptionCard(
            text: "Move to a higher floor immediately",
            isSelected: false,
            onSelect: {}
        )
        GameOptionCard(
            text: "Help neighbours evacuate first",
            isSelected: true,
            onSelect: {}
        )
    }
    .padding(.top, 20)
    .background(Color("Beige3"))
}
