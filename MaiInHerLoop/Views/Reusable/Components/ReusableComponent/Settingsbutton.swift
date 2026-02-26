//
//  SettingsButton.swift
//  MaiInHerLoop
//
//  Created by Huynh Ngoc Nhat Mai on 26/2/26.
//

import SwiftUI

/// Reusable settings button + modal pair.
/// Drop into any view's ZStack to get a top-right gear icon that opens the settings overlay.
///
/// Usage:
///   ZStack {
///       // ... your view content ...
///       SettingsButton()
///   }
struct SettingsButton: View {

    @State private var showSettings = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    // MARK: - Responsive
    private var isIPad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
    private var trailingPad: CGFloat { isIPad ? 24 : 16 }
    private var topPad: CGFloat { isIPad ? 16 : 10 }

    var body: some View {
        ZStack {
            // Gear button — top right
            VStack {
                HStack {
                    Spacer()

                    CustomMiniButton(
                        systemIcon: "gearshape.fill",
                        buttonColor: Color("Beige2"),
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
                        borderShape: "panel-border-004",
                        borderColor: Color("Beige2"),
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
