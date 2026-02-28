import SwiftUI

// MARK: - HowToPlayView

struct HowToPlayView: View {

    @AppStorage("selectedLanguage") private var language = "en"
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @State private var currentIndex: Int = 0
    @Environment(\.dismiss) private var dismiss

    private let sections = HowToPlayContent.sections
    private var section: HowToPlaySection { sections[currentIndex] }
    private var isFirst: Bool { currentIndex == 0 }
    private var isLast:  Bool { currentIndex == sections.count - 1 }

    private var isIPad:      Bool    { UIDevice.current.userInterfaceIdiom == .pad }
    private var panelWidth:  CGFloat { isIPad ? 540 : 360 }
    private var panelHeight: CGFloat { isIPad ? 660 : 560 }
    private var hPad:        CGFloat { isIPad ? 32 : 24 }
    private var topPad: CGFloat { isIPad ? 16 : 56 }
    private var sectionTitle: String { language == "vi" ? section.titleVI : section.titleEN }
    private var sectionBody:  String { language == "vi" ? section.bodyVI  : section.bodyEN  }

    var body: some View {
        ZStack {
                Image("Background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .accessibilityHidden(true)
            
            VStack(alignment: .center, spacing: 24) {
                mainPanel
                
                CustomButton(
                    title: language == "vi" ? "Về Trang Chủ" : "Back To Home",
                    textColor: Color("Beige"),
                    buttonColor: Color("Red3")
                ) {
                    dismiss()
                }
                .customedBorder(
                    borderShape: "panel-border-008",
                    borderColor: Color("Gold3"),
                    buttonType: .mainButton
                )
            }
            .chronicleFade()
        }
        .navigationBarHidden(true)
    }

    // MARK: - Panel

    private var mainPanel: some View {
        CustomPanel(
            backgroundColor: .clear,
            size: .customed(width: panelWidth, height: panelHeight)
        ) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color("Beige3"))
                    .frame(width: panelWidth - 8, height: panelHeight - 8)
                    .accessibilityHidden(true)

                VStack(spacing: 0) {
                    panelHeader
                    sectionTitleBlock
                    contentScrollArea
                    
                    Text("diary.detail.scroll_hint".localized)
                        .font(.system(.caption2).weight(.regular).italic())
                        .foregroundColor(Color("Moss").opacity(0.5))
                        .padding(.top, 4)
                        .accessibilityHidden(true)
                    
                    archetypeStrip
                    dividerBottom
                    navigationRow
                }
            }
        }
        .customedBorder(
            borderShape: "panel-border-004",
            borderColor: Color("Moss"),
            buttonType: .customed(width: panelWidth, height: panelHeight)
        )
    }

    // MARK: - Header

    private var panelHeader: some View {
        VStack(spacing: 6) {
            BarRow(color: Color("Moss"))
                .padding(.top, 30)

            Text(language == "vi" ? "HƯỚNG DẪN" : "HOW TO PLAY")
                .font(.system(.subheadline, design: .monospaced).weight(.black))
                .foregroundColor(Color("Red3"))
                .tracking(2)
                .padding(.top, 10)
                .accessibilityAddTraits(.isHeader)

            DiamondDivider(color: Color("Moss"))
                .padding(.horizontal, hPad)
                .accessibilityHidden(true)
        }
        .padding(.vertical, 10)
        .chronicleFade()
    }

    // MARK: - Section title

    private var sectionTitleBlock: some View {
        Text(sectionTitle)
            .font(.system(.caption, design: .monospaced).weight(.medium))
            .foregroundColor(Color("Red3"))
            .tracking(1.2)
            .multilineTextAlignment(.center)
            .padding(.horizontal, hPad)
            .padding(.bottom, 8)
            .id("title_\(currentIndex)")
            .transition(.opacity)
            .accessibilityAddTraits(.isHeader)
            .chronicleFade()
    }

    // MARK: - Body scroll

    private var contentScrollArea: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Text(sectionBody)
                .font(.system(.footnote, design: .monospaced))
                .foregroundColor(Color("Moss"))
                .lineSpacing(5)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 6)
                .id("body_\(currentIndex)")
        }
        .padding(.horizontal, hPad)
        .frame(maxHeight: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color("Beige"))
                .padding(.horizontal, hPad - 6)
        )
        .padding(.bottom, 8)
    }

    // MARK: - Archetype strip (section index 3 only)

    @ViewBuilder
    private var archetypeStrip: some View {
        if currentIndex == 3 {
            let ids = ["risk_recognition", "information_first", "immediate_action", "self_reliance"]
            VStack(spacing: 6) {
                SquareDivider(color: Color("Moss"))
                    .padding(.horizontal, hPad)
                    .accessibilityHidden(true)

                HStack(spacing: isIPad ? 20 : 14) {
                    ForEach(ids, id: \.self) { id in
                        if let a = ArchetypeRepository.archetype(for: id) {
                            VStack(spacing: 4) {
                                Image(a.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: isIPad ? 52 : 40, height: isIPad ? 52 : 40)
                                    .accessibilityHidden(true)

                                Text(language == "vi" ? a.nameVI : a.nameEN)
                                    .font(.system(size: isIPad ? 9 : 7.5, weight: .medium, design: .monospaced))
                                    .foregroundColor(Color("Moss").opacity(0.75))
                                    .multilineTextAlignment(.center)
                                    .lineLimit(2)
                                    .frame(width: isIPad ? 64 : 50)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .accessibilityElement(children: .ignore)
                .accessibilityLabel(
                    language == "vi"
                        ? "Bốn vật phẩm: Cái Nịt, Giỏ Chợ, Dép Tổ Ong, Cục Gạch"
                        : "Four objects: Rubber Bands, Market Basket, Honeycomb Slipper, A Brick"
                )
            }
            .transition(.opacity)
            .padding(.bottom, 4)
        }
    }

    // MARK: - Bottom divider

    private var dividerBottom: some View {
        SquareDivider(color: Color("Moss"))
            .padding(.horizontal, hPad)
            .padding(.top, 4)
            .accessibilityHidden(true)
            .chronicleFade()
    }

    // MARK: - Nav row

    private var navigationRow: some View {
        HStack(alignment: .center, spacing: 10) {
            Text(String(format: "%02d / %02d", currentIndex + 1, sections.count))
                .font(.system(.caption2, design: .monospaced).weight(.medium))
                .foregroundColor(Color("Moss").opacity(0.55))
                .tracking(2)

            Spacer()

            if !isFirst {
                navMiniButton(systemIcon: "chevron.left", action: goBack)
                    .accessibilityLabel(language == "vi" ? "Phần trước" : "Previous section")
            }

            if !isLast {
                navMiniButton(systemIcon: "chevron.right", action: goForward)
                    .accessibilityLabel(language == "vi" ? "Phần tiếp theo" : "Next section")
            }
        }
        .padding(.horizontal, hPad)
        .padding(.top, 10)
        .padding(.bottom, 20)
    }

    private func navMiniButton(systemIcon: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            ZStack {
                Color("Red3")
                Image(systemName: systemIcon)
                    .font(.system(.footnote).weight(.bold))
                    .foregroundColor(Color("Beige"))
            }
            .frame(width: 44, height: 44)
        }
        .buttonStyle(ScaleButtonStyle())
        .customedBorder(
            borderShape: "panel-border-008",
            borderColor: Color("Gold3"),
            buttonType: .miniButton
        )
    }

    private func goForward() {
        guard !isLast else { return }
        withAnimation(.easeOut(duration: 0.2)) { currentIndex += 1 }
    }

    private func goBack() {
        guard !isFirst else { return }
        withAnimation(.easeOut(duration: 0.2)) { currentIndex -= 1 }
    }
}

// MARK: - Previews
#Preview("en") {
    NavigationStack {
        HowToPlayView()
            .onAppear { UserDefaults.standard.set("vi", forKey: "selectedLanguage") }
    }
}
