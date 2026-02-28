import SwiftUI

struct MissionBriefingOverlay: View {
    let scenario: Scenario
    let missionIndex: Int
    let onRespond: () -> Void
    let onRetreat: () -> Void

    @AppStorage("selectedLanguage") private var language = "en"
    @AppStorage("playerName") private var playerName = ""
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @State private var pulseAnimation = false
    @State private var borderPulse    = false

    // MARK: - Responsive sizing
    private var isIPad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
    private var panelWidth:  CGFloat { isIPad ? 480 : 340 }
    private var panelHeight: CGFloat { isIPad ? 640 : 520 }
    private var hPad:        CGFloat { isIPad ? 35 : 30 }

    private var title: String {
        language == "vi" ? scenario.titleVI : scenario.titleEN
    }
    private var intro: String {
        let raw = language == "vi" ? scenario.introVI : scenario.introEN
        return raw.replacingOccurrences(of: "[Name]", with: displayName)
    }
    
    private var displayName: String {
        playerName.isEmpty ? "[Name]" : playerName
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            Color(.black).opacity(0.7)
                .ignoresSafeArea(.all)
                .accessibilityHidden(true)

            CustomPanel(
                backgroundColor: Color.clear,
                size: .customed(width: panelWidth, height: panelHeight)
            ) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color("Beige3"))
                        .frame(width: panelWidth - 5, height: panelHeight - 5)
                        .accessibilityHidden(true)

                    VStack(spacing: 0) {

                        // MARK: - Header
                        VStack(spacing: 8) {
                            BarRow(color: Color("Moss"))
                                .chronicleFade()
                                .padding(.top, 10)

                            Text(title)
                                .font(.system(.title3, design: .monospaced).weight(.black))
                                .foregroundColor(Color("Red3"))
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                                .tracking(1.5)
                                .opacity(pulseAnimation ? 1.0 : 0.8)
                                .accessibilityAddTraits(.isHeader)
                                .padding(.top, 10)

                            SquareDivider(color: Color("Moss"))
                                .padding(.horizontal, isIPad ? 100 : 60)
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 16)
                        .chronicleFade()

                        // MARK: - Threat Level Row
                        HStack(alignment: .center, spacing: 8) {
                            Text("threat.level".localized)
                                .font(.system(.callout, design: .monospaced).weight(.black))
                                .foregroundColor(Color("Red3"))
                                .fixedSize(horizontal: true, vertical: false)

                            Spacer()

                            HStack(spacing: 4) {
                                ForEach(1...5, id: \.self) { level in
                                    let filled = level <= scenario.danger
                                    Rectangle()
                                        .fill(filled ? Color("Red3").opacity(0.8) : Color("Red3").opacity(0.5))
                                        .frame(width: isIPad ? 14 : 10, height: isIPad ? 22 : 18)
                                        .overlay(
                                            Rectangle()
                                                .stroke(Color("Red3").opacity(0.5), lineWidth: 1.5)
                                        )
                                        .scaleEffect(pulseAnimation && filled ? 1.08 : 1.0)
                                }
                            }
                            .accessibilityElement(children: .ignore)
                            .accessibilityLabel(
                                String(
                                    format: NSLocalizedString("threat.level.accessibility", comment: ""),
                                    scenario.danger, 5
                                )
                            )
                        }
                        .padding(.horizontal, hPad)
                        .padding(.bottom, 15)
                        .chronicleFade()


                        // MARK: - Scenario title 
                        Text("dispatch.incoming".localized)
                            .font(.system(.subheadline, design: .monospaced).weight(.bold))
                            .foregroundColor(Color("Moss"))
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                            .minimumScaleFactor(0.8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, hPad)
                            .padding(.bottom, 10)
                            .chronicleFade()

                        // MARK: - Intro ScrollView
                        ScrollView(.vertical, showsIndicators: false) {
                            Text(intro)
                                .font(.system(.footnote, design: .monospaced).weight(.medium))
                                .foregroundColor(Color("Moss"))
                                .lineSpacing(3)
                                .multilineTextAlignment(.leading)
                                .padding(12)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color("Red3").opacity(0.06))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(
                                            Color("Red3").opacity(borderPulse ? 0.5 : 0.25),
                                            lineWidth: 1.5
                                        )
                                )
                        )
                        .padding(.horizontal, hPad)
                        .padding(.bottom, 4)
                        .chronicleFade()

                        Text("dispatch.scroll_guide".localized)                  .font(.system(.caption2, design: .monospaced).weight(.bold))
                            .foregroundColor(Color("Moss").opacity(0.7))
                            .padding(.bottom, 10)
                            .chronicleFade()
                            .accessibilityHidden(true)

                        // MARK: - Actions
                        VStack(spacing: 5) {
                            CustomButton(
                                title: "dispatch.respond".localized,
                                textColor: Color("Beige"),
                                buttonColor: Color("Red3")
                            ) {
                                onRespond()
                            }
                            .customedBorder(
                                borderShape: "panel-border-008",
                                borderColor: Color("Gold3"),
                                buttonType: .mainButton
                            )
                            .scaleEffect(pulseAnimation ? 1.03 : 1.0)
                            .accessibilityLabel("dispatch.respond".localized)
                            .accessibilityHint("dispatch.ready_prompt".localized)

                            CustomButton(
                                title: "dispatch.not_ready".localized,
                                textColor: Color("Moss"),
                                buttonColor: Color("Beige")
                            ) {
                                onRetreat()
                            }
                            .customedBorder(
                                borderShape: "panel-border-008",
                                borderColor: Color("Gold3"),
                                buttonType: .mainButton
                            )
                            .accessibilityLabel("dispatch.not_ready".localized)
                            .accessibilityHint("dispatch.retreat_hint".localized)
                        }
                        .chronicleFade()
                        .padding(.bottom, 25)
                    }
                    .padding(.horizontal, 15)

                    // MARK: - Corner decorations (decorative only)
                    VStack {
                        HStack {
                            cornerMark(top: true, left: true)
                            Spacer()
                            cornerMark(top: true, left: false)
                        }
                        Spacer()
                        HStack {
                            cornerMark(top: false, left: true)
                            Spacer()
                            cornerMark(top: false, left: false)
                        }
                    }
                    .padding(12)
                    .chronicleFade()
                    .accessibilityHidden(true)
                }
            }
            .customedBorder(
                borderShape: "panel-border-004",
                borderColor: Color("Moss"),
                buttonType: .customed(width: panelWidth, height: panelHeight)
            )
            .overlayAppear()
        }
        .onAppear {
            guard !reduceMotion else { return }
            withAnimation(Animation.easeInOut(duration: 1.8).repeatForever(autoreverses: true)) {
                pulseAnimation = true
            }
            withAnimation(Animation.easeInOut(duration: 2.2).repeatForever(autoreverses: true).delay(0.3)) {
                borderPulse = true
            }
        }
    }

    // MARK: - Corner decoration helper

    @ViewBuilder
    private func cornerMark(top: Bool, left: Bool) -> some View {
        VStack(spacing: 1) {
            if top {
                HStack(spacing: 1) {
                    if left {
                        Rectangle().fill(Color("Moss")).frame(width: 8, height: 1)
                        Rectangle().fill(Color("Moss").opacity(0.6)).frame(width: 4, height: 1)
                    } else {
                        Rectangle().fill(Color("Moss").opacity(0.6)).frame(width: 4, height: 1)
                        Rectangle().fill(Color("Moss")).frame(width: 8, height: 1)
                    }
                }
                HStack(spacing: 1) {
                    if left {
                        Rectangle().fill(Color("Moss").opacity(0.8)).frame(width: 1, height: 8)
                        Spacer()
                    } else {
                        Spacer()
                        Rectangle().fill(Color("Moss").opacity(0.8)).frame(width: 1, height: 8)
                    }
                }
            } else {
                HStack(spacing: 1) {
                    if left {
                        Rectangle().fill(Color("Moss").opacity(0.8)).frame(width: 1, height: 8)
                        Spacer()
                    } else {
                        Spacer()
                        Rectangle().fill(Color("Moss").opacity(0.8)).frame(width: 1, height: 8)
                    }
                }
                HStack(spacing: 1) {
                    if left {
                        Rectangle().fill(Color("Moss")).frame(width: 8, height: 1)
                        Rectangle().fill(Color("Moss").opacity(0.6)).frame(width: 4, height: 1)
                    } else {
                        Rectangle().fill(Color("Moss").opacity(0.6)).frame(width: 4, height: 1)
                        Rectangle().fill(Color("Moss")).frame(width: 8, height: 1)
                    }
                }
            }
        }
        .frame(width: 12, height: 12)
    }
}

// MARK: - Preview

#Preview {
    MissionBriefingOverlay(
        scenario: Scenario(
            id: "south_easy_1",
            region: "south",
            danger: 2,
            titleEN: "The 18th Floor",
            titleVI: "Tầng 18",
            introEN: "fefefefefefefefefefeffefefefefeffefefefefeffefefefefeffefefefefeffefefefefeff",
            introVI: "fefefefefeffefefefefeffefefefefeffefefefefeffefefefefef",
            insightEN: "Heavy rain has been falling for 6 hours. The streets are rising. You are inside a building with no clear escape route and the water is still coming.",
            insightVI: "Mưa lớn đã rơi suốt 6 giờ. Mặt đường đang dâng lên. Bạn đang ở trong tòa nhà.",
            startQuestionID: "q1",
            questions: []
        ),
        missionIndex: 0,
        onRespond: {},
        onRetreat: {}
    )
}
