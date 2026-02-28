import SwiftUI

struct StoryView: View {

    // MARK: - State
    @AppStorage("selectedLanguage") private var language = "en"
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @State private var currentIndex: Int = 0
    @State private var navigateToRegion: Bool = false
    @State private var typingComplete: Bool = false

    // MARK: - Derived helpers
    private var isFirst:  Bool { currentIndex == 0 }
    private var isLast:   Bool { currentIndex == storyBeats.count - 1 }
    private var beat:     StoryBeat { storyBeats[currentIndex] }
    private var beatText: String { beat.text(for: language) }

    // MARK: - Responsive sizing
    private var isIPad:      Bool    { UIDevice.current.userInterfaceIdiom == .pad }
    private var panelWidth:  CGFloat { isIPad ? 520 : 340 }
    private var panelHeight: CGFloat { isIPad ? 560 : 440 }
    private var hPad:        CGFloat { isIPad ? 32 : 22 }
    private var bodyFont:    Font    { isIPad ? .body : .callout }

    // MARK: - Body
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .accessibilityHidden(true)

            storyPanel
        }
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $navigateToRegion) {
            HomeView()
        }
    }

    // MARK: - Story Panel
    private var storyPanel: some View {
        CustomPanel(
            backgroundColor: .clear,
            size: .customed(width: panelWidth, height: panelHeight)
        ) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("Beige3"))
                    .frame(width: panelWidth - 8, height: panelHeight - 8)
                    .accessibilityHidden(true)

                VStack(spacing: 0) {

                    BarRow(color: Color("Gold3"))
                        .padding(.top, 18)
                        .chronicleFade()

                    Text(sectionLabel)
                        .font(.system(.caption2, design: .monospaced).weight(.medium))
                        .foregroundColor(Color("Moss").opacity(0.65))
                        .tracking(3)
                        .padding(.top, 10)
                        .chronicleFade()
                        .accessibilityLabel(sectionAccessibilityLabel)

                    DiamondDivider(color: Color("Gold3"))
                        .padding(.top, 8)
                        .padding(.horizontal, hPad)
                        .chronicleFade()

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

                    SquareDivider(color: Color("Gold3"))
                        .padding(.top, 10)
                        .padding(.horizontal, hPad)
                        .chronicleFade()

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
    private var navigationRow: some View {
        HStack(alignment: .center, spacing: 10) {

            skipButton

            Spacer()

            if !isFirst {
                navMiniButton(direction: .back, action: goBack)
            }

            if isLast {
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
    private var skipButton: some View {
        Button { navigateToRegion = true } label: {
            Text("story.skip".localized)
                .font(.system(.caption2, design: .monospaced).weight(.regular))
                .foregroundColor(Color("Moss"))
                .underline()
                .frame(minWidth: 44, minHeight: 44)
                .contentShape(Rectangle())
        }
        .accessibilityLabel("story.skip.a11y".localized)
        .accessibilityHint("story.skip.a11y.hint".localized)
    }

    // MARK: - Enter button
    private var enterButton: some View {
        CustomButton(
            title: "story.enter".localized,
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
        .accessibilityLabel("story.enter.a11y".localized)
    }

    // MARK: - Nav mini button 
    private func navMiniButton(direction: NavDirection, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            ZStack {
                Color("Red3")
                Image(systemName: direction == .forward ? "chevron.right" : "chevron.left")
                    .font(.system(.footnote).weight(.bold))
                    .foregroundColor(Color("Gold3"))
            }
            .frame(width: 44, height: 44)
        }
        .buttonStyle(ScaleButtonStyle())
        .customedBorder(
            borderShape: "panel-border-003",
            borderColor: Color("Gold3"),
            buttonType: .miniButton
        )
        .accessibilityLabel(direction == .forward
               ? "story.nav.next".localized
               : "story.nav.previous".localized)
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
