//
//  BackButton.swift
import SwiftUI

struct BackButton: View {

    // MARK: - Customisation
    var iconColor: Color = Color("Moss")
    var borderColor: Color = Color("Moss")

    // MARK: - Environment
    @Environment(\.dismiss) private var dismiss
    @AppStorage("selectedLanguage") private var language = "en"

    // MARK: - Responsive
    private var isIPad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
    private var leadingPad: CGFloat { isIPad ? 24 : 12 }
    private var topPad: CGFloat { isIPad ? 16 : 10 }

    var body: some View {
        VStack {
            HStack {
                CustomMiniButton(
                    systemIcon: "chevron.left",
                    buttonColor: iconColor,
                    action: { dismiss() }
                )
                .customedBorder(
                    borderShape: "panel-border-004",
                    borderColor: borderColor,
                    buttonType: .miniButton
                )
                .accessibilityLabel(language == "vi" ? "Quay lại" : "Go back")
                .accessibilityHint(language == "vi"
                    ? "Quay về màn hình trước"
                    : "Return to previous screen")

                Spacer()
            }
            .padding(.leading, leadingPad)
            .padding(.top, topPad)

            Spacer()
        }
    }
}

// MARK: - Preview
#Preview("Back Button — Moss") {
    ZStack {
        Color("Beige3").ignoresSafeArea()
        BackButton()
    }
}

#Preview("Back Button — Red theme") {
    ZStack {
        Color("Beige3").ignoresSafeArea()
        BackButton(iconColor: Color("Red3"), borderColor: Color("Gold3"))
    }
}
