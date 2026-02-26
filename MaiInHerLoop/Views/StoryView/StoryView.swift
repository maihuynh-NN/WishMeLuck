//
//  StoryView.swift
//  MaiInHerLoop
//
//

import SwiftUI

struct StoryView: View {

    // MARK: - State
    @AppStorage("selectedLanguage") private var language = "en"
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @State private var currentIndex: Int = 0
    @State private var navigateToRegion: Bool = false
    @State private var typingComplete: Bool = false   // gates Enter button appearance

    // MARK: - Derived helpers
    private var isFirst:  Bool { currentIndex == 0 }
    private var isLast:   Bool { currentIndex == storyBeats.count - 1 }
    private var beat:     StoryBeat { storyBeats[currentIndex] }
    private var beatText: String { beat.text(for: language) }

    // MARK: - Responsive sizing — same pattern as MissionBriefingOverlay
    private var isIPad:      Bool    { UIDevice.current.userInterfaceIdiom == .pad }
    private var panelWidth:  CGFloat { isIPad ? 520 : 340 }
    private var panelHeight: CGFloat { isIPad ? 560 : 440 }
    private var hPad:        CGFloat { isIPad ? 32 : 22 }
    private var bodyFont:    Font    { isIPad ? .body : .callout }

    // MARK: - Body
    var body: some View {
        ZStack {
            // ── Full-bleed background image ──
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            // ── Subtle dim so panel pops ──
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .accessibilityHidden(true)

            // ── Centred panel ──
            storyPanel
        }
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $navigateToRegion) {
            RegionSelectionView()
        }
    }

    // MARK: - Story Panel
    // Mirrors MissionBriefingOverlay: CustomPanel(.clear) + inner ZStack for
    // manual background control, fixed customed(width:height:), ScrollView for text.
    private var storyPanel: some View {
        CustomPanel(
            backgroundColor: .clear,
            size: .customed(width: panelWidth, height: panelHeight)
        ) {
            ZStack {
                // Burnt/smoky background — manually controlled opacity
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("Beige3").opacity(0.88))
                    .frame(width: panelWidth - 6, height: panelHeight - 6)
                    .accessibilityHidden(true)

                VStack(spacing: 0) {

                    // ── Header ornament ──
                    BarRow(color: Color("Gold3"))
                        .padding(.top, 18)
                        .chronicleFade()

                    // ── Section counter e.g. "01 / 04" ──
                    Text(sectionLabel)
                        .font(.system(.caption2, design: .monospaced).weight(.medium))
                        .foregroundColor(Color("Moss").opacity(0.65))
                        .tracking(3)
                        .padding(.top, 10)
                        .chronicleFade()
                        .accessibilityLabel(sectionAccessibilityLabel)

                    // ── Divider ──
                    DiamondDivider(color: Color("Gold3"))
                        .padding(.top, 8)
                        .padding(.horizontal, hPad)
                        .chronicleFade()

                    // ── Scrollable typewriter text ──
                    // ScrollView prevents overflow for longer beats.
                    // .id(currentIndex) destroys+recreates the TypewriterModifier,
                    // restarting the animation cleanly on each beat change.
                    ScrollView(.vertical, showsIndicators: false) {
                        Text("")
                            .typewriter(beatText, speed: 0.025, onComplete: {
                                withAnimation(.easeIn(duration: 0.4)) {
                                    typingComplete = true
                                }
                            })
                            .font(bodyFont)
                            .foregroundColor(Color("Moss"))
                            .lineSpacing(5)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 10)
                            .id(currentIndex)
                    }
                    .padding(.horizontal, hPad)
                    .padding(.top, 10)

                    // ── Bottom divider ──
                    SquareDivider(color: Color("Gold3"))
                        .padding(.top, 10)
                        .padding(.horizontal, hPad)
                        .chronicleFade()

                    // ── Navigation row ──
                    navigationRow
                        .padding(.horizontal, hPad)
                        .padding(.top, 12)
                        .padding(.bottom, 20)
                }
            }
        }
        .customedBorder(
            borderShape: "panel-border-003",
            borderColor: Color("Gold3"),
            buttonType: .customed(width: panelWidth, height: panelHeight)
        )
        .chronicleFade()
    }

    // MARK: - Navigation Row
    // First beat  → [skip] ··········· [▶]
    // Middle beat → [skip]  [◀]  [▶]
    // Last beat   → [skip]  [◀]  [ENTER ▶]  (Enter fades in after typing done)
    private var navigationRow: some View {
        HStack(alignment: .center, spacing: 10) {

            skipButton

            Spacer()

            if !isFirst {
                navMiniButton(direction: .back, action: goBack)
            }

            if isLast {
                // Enter replaces forward — appears only after typing finishes
                if typingComplete {
                    enterButton
                        .transition(.opacity.combined(with: .scale(scale: 0.92)))
                }
            } else {
                navMiniButton(direction: .forward, action: goForward)
            }
        }
    }

    // MARK: - Skip button
    // Quiet text-link style — visually subordinate to nav buttons.
    // min 44×44 contentShape satisfies HIG Rule 1 without inflating visual size.
    private var skipButton: some View {
        Button { navigateToRegion = true } label: {
            Text(language == "vi" ? "Bỏ qua" : "Skip")
                .font(.system(size: 12, weight: .light, design: .monospaced))
                .foregroundColor(Color("Moss").opacity(0.55))
                .underline()
                .frame(minWidth: 44, minHeight: 44)
                .contentShape(Rectangle())
        }
        .accessibilityLabel(language == "vi" ? "Bỏ qua phần giới thiệu" : "Skip introduction")
        .accessibilityHint(language == "vi" ? "Chuyển thẳng đến chọn vùng" : "Go directly to region selection")
    }

    // MARK: - Enter / Finish button (last beat, post-typewriter)
    private var enterButton: some View {
        CustomButton(
            title: language == "vi" ? "Bắt Đầu  ▶" : "Enter  ▶",
            textColor: Color("Beige3"),
            buttonColor: Color("Red3")
        ) {
            navigateToRegion = true
        }
        .customedBorder(
            borderShape: "panel-border-003",
            borderColor: Color("Gold3"),
            buttonType: .mainButton
        )
        .accessibilityLabel(language == "vi" ? "Bắt đầu khám phá vùng đất" : "Begin region exploration")
    }

    // MARK: - Nav mini button
    // Built inline (not CustomMiniButton) because CustomMiniButton only accepts
    // asset icon names — we're using SF Symbols here.
    private func navMiniButton(direction: NavDirection, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            ZStack {
                Color("Red3")
                Image(systemName: direction == .forward ? "chevron.right" : "chevron.left")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(Color("Gold3"))
            }
            .frame(width: 44, height: 44) // HIG Rule 1: 44×44 minimum tap target
        }
        .buttonStyle(ScaleButtonStyle())
        .customedBorder(
            borderShape: "panel-border-003",
            borderColor: Color("Gold3"),
            buttonType: .miniButton
        )
        .accessibilityLabel(direction == .forward
            ? (language == "vi" ? "Phần tiếp theo" : "Next section")
            : (language == "vi" ? "Phần trước"    : "Previous section"))
    }

    // MARK: - Navigation actions
    private func goForward() {
        guard !isLast else { return }
        typingComplete = false
        currentIndex += 1
    }

    private func goBack() {
        guard !isFirst else { return }
        typingComplete = false
        currentIndex -= 1
    }

    // MARK: - Computed strings
    private var sectionLabel: String {
        String(format: "%02d / %02d", currentIndex + 1, storyBeats.count)
    }

    private var sectionAccessibilityLabel: String {
        language == "vi"
            ? "Phần \(currentIndex + 1) trên \(storyBeats.count)"
            : "Section \(currentIndex + 1) of \(storyBeats.count)"
    }
}

// MARK: - Internal enum
private enum NavDirection { case forward, back }

// MARK: - Previews
#Preview("English") {
    NavigationStack { StoryView() }
}

#Preview("Vietnamese") {
    NavigationStack {
        StoryView()
            .onAppear { UserDefaults.standard.set("vi", forKey: "selectedLanguage") }
    }
}
