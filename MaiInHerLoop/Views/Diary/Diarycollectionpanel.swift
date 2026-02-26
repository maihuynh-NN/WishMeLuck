import SwiftUI

struct DiaryCollectionPanel: View {
    let entries: [DiaryEntry]
    let language: String

    // Count occurrences of each archetypeID
    private var objectCounts: [(archetype: Archetype, count: Int)] {
        let allIDs = ["risk_recognition", "information_first", "immediate_action", "self_reliance"]
        return allIDs.compactMap { id -> (Archetype, Int)? in
            guard let a = ArchetypeRepository.archetype(for: id) else { return nil }
            let count = entries.filter { $0.archetypeID == id }.count
            guard count > 0 else { return nil }
            return (a, count)
        }
        .sorted { $0.count > $1.count } // most collected first
    }

    private var isIPad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
    private var imageSize: CGFloat { isIPad ? 64 : 52 }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            Text("diary.collection.title".localized)                .font(.system(.caption2, design: .monospaced).weight(.bold))
                .foregroundColor(Color("Moss"))
                .tracking(2)
                .padding(.horizontal, 20)
                .padding(.top, 18)
                .accessibilityAddTraits(.isHeader)

            DiamondDivider(color: Color("Moss"))
                .padding(.horizontal, 20)
                .padding(.top, 10)
                .accessibilityHidden(true)

            if objectCounts.isEmpty {
                emptyState
            } else {
                objectGrid
            }

            DiamondDivider(color: Color("Moss"))
                .padding(.horizontal, 20)
                .padding(.bottom, 18)
                .accessibilityHidden(true)
        }
        .frame(maxWidth: .infinity)
        .background(Color("Beige").opacity(0.5))
        .customedBorder(
            borderShape: "panel-border-003",
            borderColor: Color("Moss"),
            buttonType: .flexible(height: .infinity)
        )
    }

    // MARK: - Object grid
    private var objectGrid: some View {
        HStack(spacing: isIPad ? 24 : 16) {
            ForEach(objectCounts, id: \.archetype.id) { item in
                VStack(spacing: 6) {
                    ZStack(alignment: .topTrailing) {
                        Image(item.archetype.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: imageSize, height: imageSize)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color("Moss").opacity(0.6), lineWidth: 1.5)
                            )

                        // Count badge
                        Text("×\(item.count)")
                            .font(.system(.caption2, design: .monospaced).weight(.black))
                            .foregroundColor(Color("Beige"))
                            .padding(.horizontal, 5)
                            .padding(.vertical, 2)
                            .background(Color("Moss"))
                            .clipShape(Capsule())
                            .offset(x: 6, y: -6)
                            .accessibilityHidden(true)
                    }

                    Text(language == "vi" ? item.archetype.nameVI : item.archetype.nameEN)
                        .font(.system(.caption2, design: .monospaced))
                        .foregroundColor(Color("Moss"))
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .frame(width: imageSize + 10)
                }
                .accessibilityElement(children: .combine)
                .accessibilityLabel(
                    "\(language == "vi" ? item.archetype.nameVI : item.archetype.nameEN), \(item.count)"
                )
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .padding(.vertical, 18)
    }

    // MARK: - Empty state
    private var emptyState: some View {
        Text("diary.collection.empty".localized)
            .font(.system(.caption, design: .monospaced).italic())
            .foregroundColor(Color("Moss").opacity(0.6))
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 24)
            .padding(.horizontal, 20)
    }
}
// MARK: - Preview
#Preview("Collection — has entries") {
    DiaryCollectionPanel(
        entries: [],
        language: "en"
    )
    .padding(20)
    .background(Color("Beige3"))
}

#Preview("Collection — empty") {
    DiaryCollectionPanel(
        entries: [],
        language: "vi"
    )
    .padding(20)
    .background(Color("Beige3"))
}

// MARK: - Preview
#Preview("Collection — has entries") {
    let context = PersistenceController(inMemory: true).container.viewContext

    let e1 = DiaryEntry(context: context)
    e1.id = UUID(); e1.archetypeID = "immediate_action"; e1.scenarioID = "south_easy_1"; e1.date = Date()

    let e2 = DiaryEntry(context: context)
    e2.id = UUID(); e2.archetypeID = "immediate_action"; e2.scenarioID = "south_easy_2"; e2.date = Date()

    let e3 = DiaryEntry(context: context)
    e3.id = UUID(); e3.archetypeID = "risk_recognition"; e3.scenarioID = "north_easy_1"; e3.date = Date()

    return DiaryCollectionPanel(entries: [e1, e2, e3], language: "en")
        .padding(20)
        .background(Color("Beige3"))
}

#Preview("Collection — empty") {
    DiaryCollectionPanel(entries: [], language: "vi")
        .padding(20)
        .background(Color("Beige3"))
}
