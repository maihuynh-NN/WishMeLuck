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

                    // Screen title — centered
                    screenTitle
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, hPad)
                        .padding(.top, 60)
                        .staggeredAppear(delay: 0.05)

                    // Collection panel
                    DiaryCollectionPanel(
                        entries: Array(entries),
                        language: language
                    )
                    .padding(.horizontal, hPad)
                    .staggeredAppear(delay: 0.12)

                    // Entry list section label
                    if !entries.isEmpty {
                        Text("diary.past_scenarios".localized)
                            .font(.system(.caption2, design: .monospaced).weight(.bold))
                            .foregroundColor(Color("Moss"))
                            .tracking(2)
                            .padding(.horizontal, hPad)
                            .staggeredAppear(delay: 0.18)
                            .accessibilityAddTraits(.isHeader)

                        // Entry rows
                        entryList
                            .staggeredAppear(delay: 0.22)
                    }

                    Spacer(minLength: 60)
                }
            }

            // MARK: - Overlaid buttons 
            BackButton(iconColor: Color("Red3"), borderColor: Color("Gold3"))
            SettingsButton()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }

    // MARK: - Screen title
    private var screenTitle: some View {
        VStack(spacing: 4) {
            Text("diary.title".localized)
                .font(.system(.title2, design: .monospaced).weight(.black))
                .foregroundColor(Color("Moss"))
                .tracking(3)
                .accessibilityAddTraits(.isHeader)

            Text("diary.subtitle".localized)
                .font(.system(.caption, design: .monospaced).italic())
                .foregroundColor(Color("Moss").opacity(0.75))
        }
    }

    // MARK: - Entry list
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
        .background(Color("Beige"))
        .customedBorder(
            borderShape: "panel-border-008",
            borderColor: Color("Moss"),
            buttonType: .flexible(height: .infinity)
        )
        .padding(.horizontal, hPad)
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
