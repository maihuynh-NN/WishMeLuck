import SwiftUI

struct SettingsModal: View {

    @Binding var isPresented: Bool

    // MARK: - Persisted State
    @AppStorage("selectedLanguage") private var language = "en"
    @AppStorage("selectedAppearance") private var appearance = "system" // "light" | "dark" | "system"

    // MARK: - Environment
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    // MARK: - Responsive
    private var isIPad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
    private var panelWidth:  CGFloat { isIPad ? 400 : 300 }
    private var panelHeight: CGFloat { isIPad ? 380 : 320 }

    // MARK: - Body
    var body: some View {
        ZStack {
            // Dimmed backdrop — tap to dismiss
            Color.black.opacity(0.6)
                .ignoresSafeArea()
                .accessibilityHidden(true)
                .onTapGesture { dismiss() }

            CustomPanel(
                backgroundColor: .clear,
                size: .customed(width: panelWidth, height: panelHeight)
            ) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color("Beige3").opacity(0.95))
                        .frame(width: panelWidth - 5, height: panelHeight - 5)
                        .accessibilityHidden(true)

                    VStack(spacing: 0) {

                        // MARK: - Header
                        headerSection
                            .padding(.top, isIPad ? 28 : 22)

                        DiamondDivider(color: Color("Moss"))
                            .padding(.horizontal, 40)
                            .padding(.vertical, 12)

                        // MARK: - Language Toggle
                        languageSection
                            .padding(.horizontal, isIPad ? 32 : 24)

                        Spacer().frame(height: isIPad ? 20 : 16)

                        // MARK: - Appearance Toggle
                        appearanceSection
                            .padding(.horizontal, isIPad ? 32 : 24)

                        Spacer()

                        // MARK: - Close Button
                        closeButton
                            .padding(.bottom, isIPad ? 28 : 22)
                    }
                }
            }
            .customedBorder(
                borderShape: "panel-border-003",
                borderColor: Color("Moss"),
                buttonType: .customed(width: panelWidth, height: panelHeight)
            )
            .panelExpand()
        }
    }

    // MARK: - Header
    private var headerSection: some View {
        VStack(spacing: 6) {
            BarRow(color: Color("Moss"), count: 7)

            Text("settings.title".localized)
                .font(.system(.callout, design: .monospaced).weight(.bold))
                .foregroundColor(Color("Moss"))
                .tracking(2)
                .accessibilityAddTraits(.isHeader)
        }
    }

    // MARK: - Language
    private var languageSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("settings.language".localized)
                .font(.system(.caption, design: .monospaced).weight(.medium))
                .foregroundColor(Color("Moss").opacity(0.7))
                .tracking(1)

            HStack(spacing: 12) {
                languageOption(code: "en", label: "English", flag: "🇬🇧")
                languageOption(code: "vi", label: "Tiếng Việt", flag: "🇻🇳")
            }
        }
    }

    private func languageOption(code: String, label: String, flag: String) -> some View {
        let isSelected = language == code

        return Button {
            language = code
        } label: {
            HStack(spacing: 8) {
                Text(flag)
                    .font(.system(.body))
                    .accessibilityHidden(true)

                Text(label)
                    .font(.system(.footnote, design: .monospaced).weight(isSelected ? .bold : .regular))
                    .foregroundColor(isSelected ? Color("Moss") : Color("Moss").opacity(0.5))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(isSelected ? Color("Beige").opacity(0.8) : Color.clear)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(
                        isSelected ? Color("Moss").opacity(0.6) : Color("Moss").opacity(0.2),
                        lineWidth: 1
                    )
            )
        }
        .buttonStyle(ScaleButtonStyle())
        .frame(minHeight: 44)                  
        .contentShape(Rectangle())
        .accessibilityLabel(label)
        .accessibilityHint(isSelected
            ? "settings.language.current".localized
            : "settings.language.switch".localized)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

    // MARK: - Appearance
    private var appearanceSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("settings.appearance".localized)
                .font(.system(.caption, design: .monospaced).weight(.medium))
                .foregroundColor(Color("Moss").opacity(0.7))
                .tracking(1)

            HStack(spacing: 10) {
                appearanceOption(value: "light",  icon: "sun.max.fill",       label: "settings.light".localized)
                appearanceOption(value: "dark",   icon: "moon.fill",          label: "settings.dark".localized)
                appearanceOption(value: "system", icon: "circle.lefthalf.filled", label: "settings.system".localized)
            }
        }
    }

    private func appearanceOption(value: String, icon: String, label: String) -> some View {
        let isSelected = appearance == value

        return Button {
            appearance = value
        } label: {
            VStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(.footnote).weight(.semibold))
                    .foregroundColor(isSelected ? Color("Moss") : Color("Moss").opacity(0.4))

                Text(label)
                    .font(.system(.caption2, design: .monospaced).weight(isSelected ? .bold : .regular))
                    .foregroundColor(isSelected ? Color("Moss") : Color("Moss").opacity(0.4))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(isSelected ? Color("Beige").opacity(0.8) : Color.clear)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(
                        isSelected ? Color("Moss").opacity(0.6) : Color("Moss").opacity(0.2),
                        lineWidth: 1
                    )
            )
        }
        .buttonStyle(ScaleButtonStyle())
        .frame(minHeight: 44)
        .contentShape(Rectangle())
        .accessibilityLabel(label)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

    // MARK: - Close
    private var closeButton: some View {
        VStack(spacing: 8) {
            DotRow(color: Color("Moss"), count: 9, dotSize: 3)

            CustomButton(
                title: "settings.close".localized,
                textColor: Color("Beige"),
                buttonColor: Color("Moss")
            ) {
                dismiss()
            }
            .customedBorder(
                borderShape: "panel-border-005",
                borderColor: Color("Gold"),
                buttonType: .mainButton
            )
            .accessibilityLabel("settings.close".localized)
            .accessibilityHint("settings.close.hint".localized)
        }
    }

    // MARK: - Dismiss
    private func dismiss() {
        if reduceMotion {
            isPresented = false
            return
        }
        withAnimation(AppAnimations.overlayFade) {
            isPresented = false
        }
    }
}

// MARK: - Preview
#Preview("Settings Modal") {
    ZStack {
        Image("Background")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()

        SettingsModal(isPresented: .constant(true))
    }
}
