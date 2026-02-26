import SwiftUI

// MARK: - Day Transition
struct DayTransitionModifier: ViewModifier {
    @State private var opacity: Double = 0
    @State private var scale: CGFloat = 1.5
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View {
        content
            .opacity(opacity)
            .scaleEffect(reduceMotion ? 1.0 : scale)
            .onAppear {
                if reduceMotion {
                    opacity = 1.0
                    return
                }
                withAnimation(AppAnimations.dayTransition) {
                    opacity = 1.0
                    scale = 1.0
                }
            }
    }
}

// MARK: - Game Start
struct GameStartModifier: ViewModifier {
    @State private var offset: CGFloat = 50
    @State private var opacity: Double = 0
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View {
        content
            .offset(y: reduceMotion ? 0 : offset)
            .opacity(opacity)
            .onAppear {
                if reduceMotion {
                    opacity = 1.0
                    return
                }
                withAnimation(AppAnimations.gameStart.delay(0.2)) {
                    offset = 0
                    opacity = 1.0
                }
            }
    }
}

// MARK: - View Extensions
extension View {
    func dayTransition() -> some View {
        modifier(DayTransitionModifier())
    }

    func gameStart() -> some View {
        modifier(GameStartModifier())
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: 24) {
        Text("Day 1 Begins")
            .font(.title)
            .padding()
            .background(Color.orange.opacity(0.2))
            .cornerRadius(12)
            .dayTransition()

        Text("Game Interface")
            .font(.title2)
            .padding()
            .background(Color.green.opacity(0.2))
            .cornerRadius(12)
            .gameStart()

    }
    .padding()
}
