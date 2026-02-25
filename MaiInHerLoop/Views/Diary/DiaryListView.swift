//
//  DiaryListView.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 6/2/26.
//
import SwiftUI
import CoreData

struct DiaryListView: View {

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \DiaryEntry.date, ascending: false)]
    )
    private var entries: FetchedResults<DiaryEntry>

    @AppStorage("selectedLanguage") private var language = "en"
    @Environment(\.dismiss) private var dismiss

    private var isIPad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
    private var hPad: CGFloat { isIPad ? 32 : 20 }

    var body: some View {
        ZStack {
            Color("Beige3").ignoresSafeArea()

            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {

                    // ── Screen title
                    screenTitle
                        .padding(.horizontal, hPad)
                        .staggeredAppear(delay: 0.05)

                    // ── Collection panel — no tap
                    DiaryCollectionPanel(
                        entries: Array(entries),
                        language: language
                    )
                    .padding(.horizontal, hPad)
                    .staggeredAppear(delay: 0.12)

                    // ── Entry list section label
                    if !entries.isEmpty {
                        Text(language == "vi" ? "CÁC TÌNH HUỐNG ĐÃ QUA" : "PAST SCENARIOS")
                            .font(.system(.caption2, design: .monospaced).weight(.bold))
                            .foregroundColor(Color("Moss"))
                            .tracking(2)
                            .padding(.horizontal, hPad)
                            .staggeredAppear(delay: 0.18)
                            .accessibilityAddTraits(.isHeader)

                        // ── Entry rows
                        entryList
                            .staggeredAppear(delay: 0.22)
                    }

                    Spacer(minLength: 60)
                }
                .padding(.top, 24)
            }

            // Back button — fixed top left
            VStack {
                HStack {
                    backButton
                    Spacer()
                }
                Spacer()
            }
            .ignoresSafeArea(edges: .top)
            .padding(.top, isIPad ? 20 : 8)
        }
        .navigationBarHidden(true)
    }

    // MARK: - Screen title
    private var screenTitle: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(language == "vi" ? "NHẬT KÝ" : "DIARY")
                .font(.system(.title2, design: .monospaced).weight(.black))
                .foregroundColor(Color("Ink"))
                .tracking(3)
                .accessibilityAddTraits(.isHeader)

            Text(language == "vi"
                 ? "Hành trình thích nghi của bạn."
                 : "Your adaptation journey.")
                .font(.system(.caption, design: .serif).italic())
                .foregroundColor(Color("Moss").opacity(0.75))
        }
    }

    // MARK: - Entry list — each row wrapped in NavigationLink
    private var entryList: some View {
        VStack(spacing: 0) {
            ForEach(Array(entries.enumerated()), id: \.element.id) { index, entry in
                NavigationLink {
                    DiaryEntryDetailView(entry: entry)
                } label: {
                    DiaryEntryRow(entry: entry, language: language)
                }
                .buttonStyle(CardSelectStyle())

                if index < entries.count - 1 {
                    Divider()
                        .background(Color("Moss").opacity(0.2))
                        .padding(.horizontal, hPad)
                }
            }
        }
        .background(Color("Beige").opacity(0.5))
        .customedBorder(
            borderShape: "panel-border-003",
            borderColor: Color("Moss"),
            buttonType: .flexible(height: .infinity)
        )
        .padding(.horizontal, hPad)
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
        .padding(.leading, 8)
    }
}

// MARK: - Preview
#Preview("Diary List — EN") {
    NavigationStack {
        DiaryListView()
            .environment(\.managedObjectContext,
                PersistenceController(inMemory: true).container.viewContext)
    }
}

#Preview("Diary List — VI") {
    NavigationStack {
        DiaryListView()
            .environment(\.managedObjectContext,
                PersistenceController(inMemory: true).container.viewContext)
            .onAppear { UserDefaults.standard.set("vi", forKey: "selectedLanguage") }
    }
}
