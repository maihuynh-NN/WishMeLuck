import SwiftUI

struct SettingsButton: View {

    @State private var showSettings = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    // MARK: - Responsive
    private var isIPad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
    private var trailingPad: CGFloat { isIPad ? 24 : 16 }
    private var topPad: CGFloat { isIPad ? 16 : 10 }

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()

                    CustomMiniButton(
                        systemIcon: "gearshape.fill",
                        buttonColor: Color("Red3"),
                        action: {
                            if reduceMotion {
                                showSettings = true
                                return
                            }
                            withAnimation(AppAnimations.overlayFade) {
                                showSettings = true
                            }
                        }
                    )
                    .customedBorder(
                        borderShape: "panel-border-002",
                        borderColor: Color("Gold3"),
                        buttonType: .miniButton
                    )
                    .accessibilityLabel("settings.button".localized)
                    .accessibilityHint("settings.button.hint".localized)
                    .padding(.trailing, trailingPad)
                    .padding(.top, topPad)
                }

                Spacer()
            }

            // Modal overlay
            if showSettings {
                SettingsModal(isPresented: $showSettings)
                    .transition(.opacity)
            }
        }
    }
}

// MARK: - Preview
#Preview("Settings Button") {
    ZStack {
        SettingsButton()
    }
}
