import SwiftUI

struct ReflectionResultView: View {
    @Environment(\.managedObjectContext) private var context
    @AppStorage("selectedLanguage") private var language = "en"
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    let snapshot: ReflectionSnapshot
    let shouldPersist: Bool

    var onGoToDiary: (() -> Void)? = nil
    var onGoToScenarios: (() -> Void)? = nil

    // MARK: - Responsive sizing
    private var isIPad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
    private var panelWidth:  CGFloat { isIPad ? 500 : 340 }
    private var panelHeight: CGFloat { isIPad ? 780 : 660 }
    private var hPad:        CGFloat { isIPad ? 32 : 24 }

    private var archetype: Archetype? {
        ArchetypeRepository.archetype(for: snapshot.archetypeID)
    }


    private func archetypeName(_ a: Archetype) -> String {
        language == "vi" ? a.nameVI : a.nameEN
    }
    private func objectImage(_ a: Archetype) -> String { a.objectImageName }
    private func teaser(_ a: Archetype) -> String {
        language == "vi" ? a.teaserVI : a.teaserEN
    }
    private func mirror(_ a: Archetype) -> String {
        language == "vi" ? a.mirrorVI : a.mirrorEN
    }
    private func explanation(_ a: Archetype) -> String {
        language == "vi" ? a.objectExplanationVI : a.objectExplanationEN
    }
    private func tradeoff(_ a: Archetype) -> String {
        language == "vi" ? a.tradeoffVI : a.tradeoffEN
    }

    // MARK: - Body
    var body: some View {
        ZStack {
            Color("Beige3").ignoresSafeArea()
            resultPanel.chronicleFade()
        }
        .onAppear {
            if shouldPersist {
                DiaryStore.save(context: context, snapshot: snapshot)
            }
            if let a = archetype {
                let msg = "reflection.result.announcement".localized + " " + archetypeName(a)
                if #available(iOS 17.0, *) {
                    AccessibilityNotification.Announcement(msg).post()
                } else {
                    UIAccessibility.post(notification: .announcement, argument: msg)
                }
            }
        }
    }

    // MARK: - Main Panel
    private var resultPanel: some View {
        CustomPanel(
            backgroundColor: .clear,
            size: .customed(width: panelWidth, height: panelHeight)
        ) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("Beige3"))
                    .frame(width: panelWidth - 6, height: panelHeight - 6)
                    .accessibilityHidden(true)

                VStack(spacing: 0) {

                    BarRow(color: Color("Moss"))
                        .padding(.top, 30)
                        .chronicleFade()
                        .accessibilityHidden(true)

                    archetypeLabel
                        .chronicleFade()

                    DiamondDivider(color: Color("Moss"))
                        .padding(.horizontal, hPad)
                        .padding(.top, 6)
                        .chronicleFade()
                        .accessibilityHidden(true)

                    objectBlock
                        .staggeredAppear(delay: 0.1)

                    mirrorSentence
                        .padding(.horizontal, hPad)
                        .staggeredAppear(delay: 0.18)

                    DiamondDivider(color: Color("Moss"))
                        .padding(.horizontal, hPad)
                        .padding(.vertical, 6)
                        .chronicleFade()
                        .accessibilityHidden(true)

                    ScrollView(.vertical, showsIndicators: false) {
                        explanationAndTradeoff
                            .padding(.horizontal, hPad)
                    }
                    .padding(.horizontal)
                    .frame(maxHeight: .infinity)

                    SquareDivider(color: Color("Moss"))
                        .padding(.horizontal, hPad)
                        .padding(.top, 8)
                        .chronicleFade()
                        .accessibilityHidden(true)
                    
                    Text("reflection.scroll.guide".localized)
                        .font(.system(.caption2, design: .monospaced).italic())
                        .foregroundColor(Color("Moss"))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 8)
                        .accessibilityHidden(true)

                    navigationButtons
                        .padding(.horizontal, hPad)
                        .padding(.top, 12)
                        .padding(.bottom, 20)
                        .staggeredAppear(delay: 0.3)
                }
            }
        }
        .customedBorder(
            borderShape: "panel-border-004",
            borderColor: Color("Moss"),
            buttonType: .customed(width: panelWidth, height: panelHeight)
        )
    }

    // MARK: - Archetype label
    @ViewBuilder
    private var archetypeLabel: some View {
        if let a = archetype {
            VStack(spacing: 4) {
                Text("reflection.result.header".localized)
                    .font(.system(.caption2, design: .monospaced).weight(.bold))
                    .foregroundColor(Color("Moss"))
                    .tracking(2)
                    .padding(.top, 5)
                    .accessibilityHidden(true)

                Text(archetypeName(a).uppercased())
                    .font(.system(.subheadline, design: .monospaced).weight(.black))
                    .foregroundColor(Color("Red3"))
                    .tracking(1.5)
                    .multilineTextAlignment(.center)
                    .padding(.top, 5)
                    .accessibilityAddTraits(.isHeader)
            }
            .padding(.top, 10)
            .padding(.bottom, 4)
        }
    }

    // MARK: - Object image + teaser
    @ViewBuilder
    private var objectBlock: some View {
        if let a = archetype {
            VStack(spacing: 8) {
                Image(objectImage(a))
                    .resizable()
                    .scaledToFit()
                    .frame(width: isIPad ? 120 : 96, height: isIPad ? 120 : 96)
                    .accessibilityHidden(true)

                Text(teaser(a))
                    .font(.system(.caption, design: .monospaced).italic())
                    .foregroundColor(Color("Moss"))
                    .multilineTextAlignment(.center)
                    .accessibilityHidden(true)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
        }
    }

    // MARK: - Mirror sentence
    @ViewBuilder
    private var mirrorSentence: some View {
        if let a = archetype {
            Text(mirror(a))
                .font(.system(.callout, design: .monospaced).weight(.semibold))
                .foregroundColor(Color("Red3"))
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.bottom, 6)
        }
    }

    // MARK: - Explanation + tradeoff (inside ScrollView)
    @ViewBuilder
    private var explanationAndTradeoff: some View {
        if let a = archetype {
            VStack(alignment: .leading, spacing: 0) {
                Text(explanation(a))
                    .font(.system(.footnote, design: .monospaced).weight(.regular))
                    .foregroundColor(Color("Moss"))
                    .lineSpacing(4)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 6)
                    .padding(.bottom, 14)

                HStack(alignment: .top, spacing: 8) {
                    Text("◆")
                        .font(.system(size: 7))
                        .foregroundColor(Color("Moss"))
                        .padding(.top, 3)
                        .accessibilityHidden(true)

                    Text(tradeoff(a))
                        .font(.system(.caption, design: .monospaced).italic())
                        .foregroundColor(Color("Moss"))
                        .lineSpacing(3)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.bottom, 10)
            }
        }
    }

    // MARK: - Navigation buttons
    private var navigationButtons: some View {
        HStack(spacing: 12) {
            CustomButton(
                title: "reflection.diary".localized,
                textColor: Color("Moss"),
                buttonColor: Color("Beige")
            ) {
                onGoToDiary?()
            }
            .customedBorder(
                borderShape: "panel-border-008",
                borderColor: Color("Gold3"),
                buttonType: .mainButton
            )
            .accessibilityLabel("reflection.diary".localized)
            .accessibilityHint("reflection.diary.hint".localized)

            CustomButton(
                title: "reflection.play_again".localized,
                textColor: Color("Beige"),
                buttonColor: Color("Red3")
            ) {
                onGoToScenarios?()
            }
            .customedBorder(
                borderShape: "panel-border-008",
                borderColor: Color("Gold3"),
                buttonType: .mainButton
            )
            .accessibilityLabel("reflection.play_again".localized)
            .accessibilityHint("reflection.play_again.hint".localized)
        }
    }
}

// MARK: - Previews
#Preview("Immediate Action — EN") {
    ReflectionResultView(
        snapshot: ReflectionSnapshot(
            archetypeID: "immediate_action",
            scenarioID: "south_easy_1"
        ),
        shouldPersist: false,
        onGoToDiary: {},
        onGoToScenarios: {}
    )
}

#Preview("Self Reliance — VI") {
    ReflectionResultView(
        snapshot: ReflectionSnapshot(
            archetypeID: "self_reliance",
            scenarioID: "north_easy_1"
        ),
        shouldPersist: false,
        onGoToDiary: {},
        onGoToScenarios: {}
    )
    .onAppear { UserDefaults.standard.set("vi", forKey: "selectedLanguage") }
}
