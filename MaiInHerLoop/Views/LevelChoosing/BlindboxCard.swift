import SwiftUI

struct BlindBoxCard: View {
    let index: Int
    let isCompleted: Bool
    let onTap: () -> Void
    var cardSize: ComponentSize = .customed(width: 60, height: 60)

    @State private var pulse = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        VStack(spacing: 6) {

            Button(action: onTap) {
                CustomPanel(
                    backgroundColor: isCompleted ? Color("Beige").opacity(0.55) : Color("Beige"),
                    size: cardSize
                ) {
                    ZStack {
                        VStack(spacing: 5) {

                            Text(String(format: "%02d", index + 1))
                                .font(.system(.title2, design: .monospaced).weight(.black))
                                .foregroundColor(
                                    isCompleted
                                        ? Color("Red3").opacity(0.55)
                                        : Color("Red3")
                                )
                                .tracking(3)
                                .accessibilityHidden(true)

                            if isCompleted {
                                Image(systemName: "checkmark")
                                    .font(.system(.caption, design: .monospaced).weight(.bold))
                                    .foregroundColor(Color("Red3").opacity(0.55))
                                    .accessibilityHidden(true)
                            } else {
                                HStack(spacing: 4) {
                                    Rectangle()
                                        .fill(Color("Moss").opacity(0.35))
                                        .frame(width: 12, height: 0.5)
                                    Circle()
                                        .fill(Color("Moss").opacity(0.5))
                                        .frame(width: 2.5, height: 2.5)
                                    Rectangle()
                                        .fill(Color("Moss").opacity(0.35))
                                        .frame(width: 12, height: 0.5)
                                }
                                .accessibilityHidden(true)
                            }
                        }
                    }
                }
            }
            .buttonStyle(CardSelectStyle())
            .accessibilityLabel(String(format: "mission.a11y.label".localized, index + 1, isCompleted ? "mission.a11y.completed".localized : "mission.a11y.locked".localized))
            .accessibilityHint(isCompleted ? "mission.a11y.hint.replay".localized : "mission.a11y.hint.start".localized)
            .customedBorder(
                borderShape: "panel-border-005",
                borderColor: isCompleted ? Color("Gold3") : Color("Gold3").opacity(pulse ? 0.9 : 0.65),
                buttonType: cardSize
            )

            Text(isCompleted ? "mission.responded".localized : "mission.classified".localized)
                .font(.system(.caption2, design: .monospaced).weight(.medium))
                .foregroundColor(Color("Red3"))
                .tracking(0.5)
                .lineLimit(1)
                .accessibilityHidden(true)
        }
        .onAppear {
            guard !reduceMotion else { return }
            withAnimation(
                Animation.easeInOut(duration: 2.0)
                    .repeatForever(autoreverses: true)
                    .delay(Double(index) * 0.3)
            ) {
                pulse = true
            }
        }
    }
}

#Preview {
    ZStack {
        Color("Beige3").ignoresSafeArea()
        VStack(spacing: 14) {
            HStack(spacing: 10) {
                BlindBoxCard(index: 0, isCompleted: false, onTap: {})
                BlindBoxCard(index: 1, isCompleted: true, onTap: {})
                BlindBoxCard(index: 2, isCompleted: false, onTap: {})
            }
            HStack(spacing: 14) {
                BlindBoxCard(index: 3, isCompleted: false, onTap: {})
                BlindBoxCard(index: 4, isCompleted: true, onTap: {})
            }
        }
    }
}
