//
//  DiaryEntryDetailView.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 25/2/26.
//
import SwiftUI
import CoreData

struct DiaryEntryDetailView: View {
    let entry: DiaryEntry

    @AppStorage("selectedLanguage") private var language = "en"
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

    private var titleText: String {
        guard let s = scenario else { return entry.scenarioID ?? "" }
        return language == "vi" ? s.titleVI : s.titleEN
    }

    private var insightText: String {
        guard let s = scenario else { return "" }
        return language == "vi" ? s.insightVI : s.insightEN
    }

    private var objectName: String {
        guard let a = archetype else { return "" }
        return language == "vi" ? a.nameVI : a.nameEN
    }

    // Tile column: ~22% on iPhone, ~18% on iPad
    private var isIPad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
    private var tileRatio: CGFloat { isIPad ? 0.18 : 0.22 }
    private var contentPad: CGFloat { isIPad ? 32 : 20 }

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .topLeading) {
                Color("Beige3").ignoresSafeArea()

                HStack(spacing: 0) {
                    // ── LEFT: Tile column — decorative, full height, fixed width
                    tileColumn(width: geo.size.width * tileRatio, height: geo.size.height)
                        .ignoresSafeArea()
                        .accessibilityHidden(true)

                    // ── RIGHT: Scrollable diary content
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 0) {
                            diaryHeader
                                .staggeredAppear(delay: 0.05)

                            DiamondDivider(color: Color("Moss"))
                                .padding(.vertical, 20)
                                .staggeredAppear(delay: 0.1)

                            collectedBlock
                                .staggeredAppear(delay: 0.15)

                            DiamondDivider(color: Color("Moss"))
                                .padding(.vertical, 20)
                                .staggeredAppear(delay: 0.2)

                            scenarioInsight
                                .staggeredAppear(delay: 0.25)

                            // Bottom safe area clearance
                            Spacer(minLength: 60)
                        }
                        .padding(.top, geo.safeAreaInsets.top + 24)
                        .padding(.horizontal, contentPad)
                        .padding(.trailing, contentPad * 0.5)
                    }
                    .frame(width: geo.size.width * (1 - tileRatio))
                }
            }
        }
        .navigationBarHidden(true)
        .overlay(alignment: .topLeading) { backButton }
    }

    // MARK: - Tile column
    private func tileColumn(width: CGFloat, height: CGFloat) -> some View {
        let tileSize = max(width, 1) // guard: never zero or NaN
        let count = height > 0 ? Int(ceil(height / tileSize)) + 1 : 2

        return ScrollView([]) {
            VStack(spacing: 0) {
                ForEach(0..<count, id: \.self) { _ in
                    Image(tileName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: tileSize, height: tileSize)
                        .clipped()
                }
            }
        }
        .frame(width: width, height: height)
        .clipped()
    }

    // MARK: - Header: "Dear Diary,"
    private var diaryHeader: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Dear Diary,")
                .font(.system(.title, design: .serif).weight(.bold))
                .foregroundColor(Color("Ink"))

            Text(language == "vi"
                 ? "Một ngày bình thường của [Name] ở Việt Nam."
                 : "A regular day of [Name]'s adaptation in Việt Nam.")
                .font(.system(.body, design: .serif))
                .foregroundColor(Color("Ink").opacity(0.75))
                .fixedSize(horizontal: false, vertical: true)

            Text(language == "vi"
                 ? "Hôm nay là \(dateString)"
                 : "Today is \(dateString)")
                .font(.system(.footnote, design: .monospaced))
                .foregroundColor(Color("Moss"))
                .padding(.top, 8)
        }
    }

    // MARK: - "I have collected a [object] [image]"
    @ViewBuilder
    private var collectedBlock: some View {
        if let a = archetype {
            VStack(alignment: .leading, spacing: 10) {
                // "I have collected a"
                Text(language == "vi" ? "Hôm nay tôi đã nhận được một" : "I have collected a")
                    .font(.system(.body, design: .serif))
                    .foregroundColor(Color("Ink").opacity(0.75))

                // Object name bold + image side by side
                HStack(alignment: .center, spacing: 14) {
                    Text(language == "vi" ? a.nameVI : a.nameEN)
                        .font(.system(.title3, design: .serif).weight(.bold))
                        .foregroundColor(Color("Ink"))
                        .fixedSize(horizontal: false, vertical: true)
                        .minimumScaleFactor(typeSize >= .accessibility1 ? 0.7 : 1.0)

                    Image(a.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 56, height: 56)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color("Moss"), lineWidth: 1.5)
                        )
                        .accessibilityHidden(true)
                }
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel(
                language == "vi"
                ? "Hôm nay tôi đã nhận được một \(a.nameVI)"
                : "I have collected a \(a.nameEN)"
            )
        }
    }

    // MARK: - Scenario title + insight
    @ViewBuilder
    private var scenarioInsight: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Scenario title — bold, chronicleFade
            Text(titleText)
                .font(.system(.callout, design: .serif).weight(.bold))
                .foregroundColor(Color("Ink"))
                .fixedSize(horizontal: false, vertical: true)
                .chronicleFade()
                .accessibilityAddTraits(.isHeader)

            // Insight paragraph
            if !insightText.isEmpty {
                Text(insightText)
                    .font(.system(.footnote))
                    .foregroundColor(Color("Ink").opacity(0.85))
                    .lineSpacing(5)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.leading)
            } else {
                // Fallback if insight not yet added to this scenario's JSON
                Text(language == "vi"
                     ? "Nội dung đang được cập nhật."
                     : "Insight coming soon.")
                    .font(.system(.footnote).italic())
                    .foregroundColor(Color("Moss").opacity(0.6))
            }

            // Scroll hint
            Text(language == "vi" ? "cuộn để đọc" : "scroll to read")
                .font(.system(.caption2, design: .serif).italic())
                .foregroundColor(Color("Moss").opacity(0.5))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 8)
                .accessibilityHidden(true)
        }
    }

    // MARK: - Back button
    private var backButton: some View {
        Button(action: { dismiss() }) {
            HStack(spacing: 6) {
                Image(systemName: "chevron.left")
                    .font(.system(.footnote).weight(.semibold))
                Text("diary.back".localized)
                    .font(.system(.footnote, design: .monospaced).weight(.medium))
            }
            .foregroundColor(Color("Moss"))
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .frame(minWidth: 44, minHeight: 44)
            .contentShape(Rectangle())
        }
        .accessibilityLabel("diary.back".localized)
        .accessibilityHint("diary.back.hint".localized)
        .padding(.top, 8)
        .padding(.leading, 4)
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
