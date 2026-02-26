//
//  DiaryEntryRow.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 25/2/26.
//
import SwiftUI

struct DiaryEntryRow: View {
    let entry: DiaryEntry
    let language: String

    private var archetype: Archetype? {
        ArchetypeRepository.archetype(for: entry.archetypeID ?? "")
    }

    private var scenario: Scenario? {
        JSONLoader.loadScenario(id: entry.scenarioID ?? "")
    }

    private var regionLabel: String {
        DiaryHelpers.regionLabel(
            DiaryHelpers.region(for: entry.scenarioID ?? ""),
            language: language
        )
    }

    private var dateLabel: String {
        guard let date = entry.date else { return "" }
        let f = DateFormatter()
        f.dateFormat = "MMM d"
        f.locale = Locale(identifier: language == "vi" ? "vi_VN" : "en_US")
        return f.string(from: date)
    }

    private var titleText: String {
        guard let s = scenario else { return entry.scenarioID ?? "" }
        return language == "vi" ? s.titleVI : s.titleEN
    }

    var body: some View {
        HStack(spacing: 12) {
            // Object image — small thumbnail
            if let a = archetype {
                Image(a.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44, height: 44)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color("Moss").opacity(0.5), lineWidth: 1)
                    )
                    .accessibilityHidden(true)
            }

            VStack(alignment: .leading, spacing: 3) {
                Text(titleText)
                    .font(.system(.footnote, design: .monospaced).weight(.semibold))
                    .foregroundColor(Color("Moss"))
                    .lineLimit(1)

                Text("\(regionLabel)  ·  \(dateLabel)")
                    .font(.system(.caption2, design: .monospaced))
                    .foregroundColor(Color("Moss").opacity(0.8))
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(.caption2).weight(.semibold))
                .foregroundColor(Color("Moss").opacity(0.5))
                .accessibilityHidden(true)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color("Beige").opacity(0.5))
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(titleText), \(regionLabel), \(dateLabel)")
        .accessibilityHint("diary.entry.hint".localized)
    }
}

// MARK: - Preview
#Preview("Entry Row") {
    let ctx = PersistenceController(inMemory: true).container.viewContext
    let e = DiaryEntry(context: ctx)
    e.id = UUID()
    e.date = Date()
    e.scenarioID = "south_easy_1"
    e.archetypeID = "risk_recognition"

    return DiaryEntryRow(entry: e, language: "en")
        .padding()
        .background(Color("Beige3"))
}

// MARK: - Preview
#Preview {
    let context = PersistenceController(inMemory: true).container.viewContext
    let e = DiaryEntry(context: context)
    e.id = UUID()
    e.archetypeID = "immediate_action"
    e.scenarioID = "south_easy_1"
    e.date = Date()

    return VStack(spacing: 0) {
        DiaryEntryRow(entry: e, language: "en")
        Divider().padding(.horizontal, 20)
        DiaryEntryRow(entry: e, language: "vi")
    }
    .background(Color("Beige3"))
}
























