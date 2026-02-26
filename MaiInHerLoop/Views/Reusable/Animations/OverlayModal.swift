import SwiftUI

// MARK: - Overlay Appear
struct OverlayAppearModifier: ViewModifier {
    @State private var opacity: Double = 0
    @State private var yOffset: CGFloat = -50
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View {
        content
            .opacity(opacity)
            .offset(y: reduceMotion ? 0 : yOffset)
            .onAppear {
                if reduceMotion {
                    opacity = 1.0
                    return
                }
                withAnimation(AppAnimations.modalSlide) {
                    opacity = 1.0
                    yOffset = 0
                }
            }
    }
}

// MARK: - Modal Slide In
struct ModalSlideInModifier: ViewModifier {
    @State private var offset: CGFloat = 300
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View {
        content
            .offset(y: reduceMotion ? 0 : offset)
            .onAppear {
                guard !reduceMotion else { return }
                withAnimation(AppAnimations.modalSlide) {
                    offset = 0
                }
            }
    }
}

// MARK: - Panel Expand
struct PanelExpandModifier: ViewModifier {
    @State private var scale: CGFloat = 0.8
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View {
        content
            .scaleEffect(reduceMotion ? 1.0 : scale)
            .onAppear {
                guard !reduceMotion else { return }
                withAnimation(AppAnimations.panelExpand) {
                    scale = 1.0
                }
            }
    }
}

// MARK: - Overlay Dismiss
struct OverlayFadeModifier: ViewModifier {
    @State private var opacity: Double = 0
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View {
        content
            .opacity(opacity)
            .onAppear {
                if reduceMotion {
                    opacity = 1.0
                    return
                }
                withAnimation(AppAnimations.overlayFade) {
                    opacity = 1.0
                }
            }
    }
}

// MARK: - View Extensions
extension View {
    func overlayAppear() -> some View {
        modifier(OverlayAppearModifier())
    }

    // For dismiss animation use .transition(.opacity) at the call site instead.
    func overlayFade() -> some View {
        modifier(OverlayFadeModifier())
    }

    func modalSlideIn() -> some View {
        modifier(ModalSlideInModifier())
    }

    func panelExpand() -> some View {
        modifier(PanelExpandModifier())
    }
}

// MARK: - Helper: selective corner radius
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.black.opacity(0.3).ignoresSafeArea()

        VStack(spacing: 20) {
            Text("Overlay Appear")
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .overlayAppear()

            Text("Panel Expand")
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .panelExpand()

            Text("Modal Slide In")
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .modalSlideIn()
        }
    }
}
