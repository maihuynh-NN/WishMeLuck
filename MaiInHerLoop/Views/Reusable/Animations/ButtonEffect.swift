import SwiftUI

struct EmergencyPulseModifier: ViewModifier {
    @State private var isPulsing = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View {
        content
            .scaleEffect(isPulsing ? 1.05 : 1.0)
            .opacity(isPulsing ? 0.7 : 1.0)
            .onAppear {
                guard !reduceMotion else { return }
                withAnimation(AppAnimations.emergencyPulse) {
                    isPulsing = true
                }
            }
    }
}

struct WarningFlashModifier: ViewModifier {
    @State private var isFlashing = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View {
        content
            .foregroundColor(isFlashing ? .orange : .yellow)
            .onAppear {
                guard !reduceMotion else { return }
                withAnimation(AppAnimations.warningFlash) {
                    isFlashing = true
                }
            }
    }
}

extension View {
    func emergencyPulse() -> some View {
        modifier(EmergencyPulseModifier())
    }

    func warningFlash() -> some View {
        modifier(WarningFlashModifier())
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: 40) {
        Button(action: {}) {
            Text("EMERGENCY SOS")
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.red)
                .cornerRadius(12)
        }
        .emergencyPulse()

        Image(systemName: "exclamationmark.triangle.fill")
            .font(.largeTitle)
            .warningFlash()
    }
    .padding()
}
