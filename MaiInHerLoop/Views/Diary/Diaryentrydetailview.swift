import SwiftUI
import CoreData

struct DiaryEntryDetailView: View {
    let entry: DiaryEntry

    @AppStorage("selectedLanguage") private var language = "en"
    @AppStorage("playerName") private var playerName = ""
    @Environment(\.dismiss) private var dismiss
    @Environment(\.dynamicTypeSize) private var typeSize

    private var archetype: Archetype? {
        ArchetypeRepository.archetype(for: entry.archetypeID ?? "")
    }

    private var scenario: Scenario? {
        JSONLoader.loadScenario(id: entry.scenarioID ?? "")
    }

    private var tileName: String {
        DiaryHelpers.tileName(for: entry.scenarioID ?? "")
    }

    private var dateString: String {
        DiaryHelpers.formattedDate(entry.date ?? Date(), language: language)
    }

    private var displayName: String {
        playerName.isEmpty ? "[Name]" : playerName
    }

    private var titleText: String {
        guard let s = scenario else { return entry.scenarioID ?? "" }
        return language == "vi" ? s.titleVI : s.titleEN
    }

    private var insightText: String {
        guard let s = scenario else { return "" }
        return language == "vi" ? s.insightVI : s.insightEN
    }

    // MARK: - Responsive
    private var isIPad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
    private var tileColumnWidth: CGFloat { isIPad ? 140 : 100 }
    private var tileSize: CGFloat { isIPad ? 150 : 110 }
    private var contentPad: CGFloat { isIPad ? 32 : 20 }

    // MARK: - Body
    var body: some View {
        ZStack {
            Color("Beige3").ignoresSafeArea()

            HStack(spacing: 0) {
                // LEFT: Tile column
                tileColumn
                    .frame(width: tileColumnWidth)
                    .accessibilityHidden(true)

                VStack(alignment: .leading, spacing: 0) {

                    VStack(alignment: .leading, spacing: 0) {
                        diaryHeader
                            .staggeredAppear(delay: 0.05)

                        DiamondDivider(color: Color("Moss"))
                            .padding(.vertical, 14)
                            .staggeredAppear(delay: 0.1)

                        collectedBlock
                            .staggeredAppear(delay: 0.15)

                        DiamondDivider(color: Color("Moss"))
                            .padding(.vertical, 14)
                            .staggeredAppear(delay: 0.2)
                    }
                    .padding(.leading, contentPad)
                    .padding(.trailing, contentPad * 0.8)

                    // SCROLLABLE: scenario title + insight text
                    ScrollView(.vertical, showsIndicators: false) {
                        scenarioInsight
                            .staggeredAppear(delay: 0.25)
                            .padding(.leading, contentPad)
                            .padding(.trailing, contentPad * 0.8)
                            .padding(.bottom, 60)
                    }
                    
                    Text("diary.detail.scroll_hint".localized)
                        .font(.system(.caption2, design: .monospaced).italic().weight(.bold))
                        .foregroundColor(Color("Moss"))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 8)
                        .padding(.bottom, isIPad ? 30 : 20)
                        .accessibilityHidden(true)
                }
                .padding(.top, isIPad ? 60 : 50)
            }
            .ignoresSafeArea()

            // MARK: - Back button (top left)
            BackButton(iconColor: Color("Red3"), borderColor: Color("Gold3"))

            // MARK: - Settings button (top right)
            SettingsButton()
        }
        .navigationBarHidden(true)
    }

    // MARK: - Tile Column (full height, edge to edge)
    private var tileColumn: some View {
        GeometryReader { geo in
            let screenHeight = geo.size.height + geo.safeAreaInsets.top + geo.safeAreaInsets.bottom
            let count = max(Int(ceil(screenHeight / tileSize)) + 1, 2)

            VStack(spacing: 0) {
                ForEach(0..<count, id: \.self) { _ in
                    Image(tileName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: tileColumnWidth, height: tileSize)
                        .clipped()
                }
            }
            .frame(width: tileColumnWidth, height: screenHeight)
            .offset(y: -geo.safeAreaInsets.top)
        }
        .frame(width: tileColumnWidth)
    }

    // MARK: - Header
    private var diaryHeader: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("diary.detail.greeting".localized)
                .font(.system(.title, design: .monospaced).weight(.bold))
                .foregroundColor(Color("Red3"))
                .fixedSize(horizontal: false, vertical: true)
                .accessibilityAddTraits(.isHeader)

            Text(String(format: "diary.detail.subtitle".localized, displayName))
                .font(.system(.body, design: .monospaced))
                .foregroundColor(Color("Red3"))
                .fixedSize(horizontal: false, vertical: true)

            Text(String(format: "diary.detail.date".localized, dateString))
                .font(.system(.footnote, design: .monospaced))
                .foregroundColor(Color("Moss"))
                .padding(.top, 8)
        }
        .padding(.top, 80)
    }

    // MARK: - Collected block
    @ViewBuilder
    private var collectedBlock: some View {
        if let a = archetype {
            let name = language == "vi" ? a.nameVI : a.nameEN

            VStack(alignment: .leading, spacing: 10) {
                Text("diary.detail.collected".localized)
                    .font(.system(.body, design: .monospaced))
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(Color("Moss"))

                HStack(alignment: .center, spacing: 14) {
                    Text(name + "!")
                        .font(.system(.title3, design: .monospaced).weight(.bold))
                        .foregroundColor(Color("Red3"))
                        .fixedSize(horizontal: false, vertical: true)
                        .minimumScaleFactor(typeSize >= .accessibility1 ? 0.7 : 1.0)

                    Spacer()

                    Image(a.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: isIPad ? 70 : 56, height: isIPad ? 70 : 56)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color("Moss"), lineWidth: 1.5)
                        )
                        .accessibilityHidden(true)
                }
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel(String(format: "diary.detail.collected.a11y".localized, name))
        }
    }

    // MARK: - Scenario insight (scrollable part)
    @ViewBuilder
    private var scenarioInsight: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(titleText)
                .font(.system(.callout, design: .monospaced).weight(.bold))
                .foregroundColor(Color("Red3"))
                .fixedSize(horizontal: false, vertical: true)
                .chronicleFade()
                .accessibilityAddTraits(.isHeader)

            if !insightText.isEmpty {
                Text(insightText)
                    .font(.system(.footnote))
                    .foregroundColor(Color("Moss"))
                    .lineSpacing(5)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.leading)
            } else {
                Text("diary.detail.insight_placeholder".localized)
                    .font(.system(.footnote).italic())
                    .foregroundColor(Color("Moss"))
            }
        }
    }
}

// MARK: - Preview
private func mockEntry(context: NSManagedObjectContext) -> DiaryEntry {
    let e = DiaryEntry(context: context)
    e.id = UUID()
    e.date = Date()
    e.scenarioID = "south_easy_1"
    e.archetypeID = "immediate_action"
    return e
}

#Preview("Entry Detail — EN") {
    let ctx = PersistenceController(inMemory: true).container.viewContext
    NavigationStack {
        DiaryEntryDetailView(entry: mockEntry(context: ctx))
            .environment(\.managedObjectContext, ctx)
    }
}

#Preview("Entry Detail — VI") {
    let ctx = PersistenceController(inMemory: true).container.viewContext
    NavigationStack {
        DiaryEntryDetailView(entry: mockEntry(context: ctx))
            .environment(\.managedObjectContext, ctx)
            .onAppear { UserDefaults.standard.set("vi", forKey: "selectedLanguage") }
    }
}
