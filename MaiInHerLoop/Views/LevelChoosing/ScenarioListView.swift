import SwiftUI

struct ScenarioListView: View {
    let region: Region

    @AppStorage("selectedLanguage") private var language = "en"
    @Environment(\.dismiss) private var dismiss
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @State private var scenarios: [Scenario] = []
    @State private var headerPulse = false
    @State private var completedIDs: Set<String> = []
    @State private var navigateToDiary = false
    @State private var activeScenarioIndex: Int? = nil

    init(region: Region) {
        self.region = region
        var loaded: [Scenario] = []
        for i in 1...5 {
            let id = "\(region.name.lowercased())_easy_\(i)"
            if let s = JSONLoader.loadScenario(id: id) {
                loaded.append(s)
            }
        }
        _scenarios = State(initialValue: loaded)
    }

    private var regionDisplayName: String {
        switch region.name {
        case "North":   return "scenariolist.region.north".localized
        case "Central": return "scenariolist.region.central".localized
        case "South":   return "scenariolist.region.south".localized
        default:        return region.name
        }
    }

    private var row1: [Scenario] { Array(scenarios.prefix(3)) }
    private var row2: [Scenario] { Array(scenarios.dropFirst(3).prefix(2)) }

    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                // MARK: - Background
                Image("Background")
                    .resizable()
                    .clipped()
                    .ignoresSafeArea(edges: .vertical)
                    .accessibilityHidden(true)

                // Hidden NavigationLinks
                VStack {
                    ForEach(scenarios.indices, id: \.self) { i in
                        NavigationLink(
                            destination: GameView(engine: ScenarioEngine(scenario: scenarios[i])),
                            isActive: Binding(
                                get: { activeScenarioIndex == i },
                                set: { if !$0 { activeScenarioIndex = nil } }
                            )
                        ) { EmptyView() }
                    }
                }
                .frame(width: 0, height: 0)
                .hidden()

                VStack(spacing: 0) {

                    // MARK: - Header
                    VStack(spacing: 12) {
                        BarRow(color: Color("Red3"))
                            .chronicleFade()
                            .padding(.top, 30)

                        Text("scenariolist.header".localized)
                            .font(.system(.caption2, design: .monospaced).weight(.bold))
                            .foregroundColor(Color("Red3"))
                            .tracking(2)
                            .chronicleFade()
                            .padding(.vertical, 4)

                        Text(regionDisplayName.uppercased())
                            .font(.system(.title2, design: .monospaced).weight(.black))
                            .foregroundColor(Color("Red3"))
                            .tracking(2)
                            .opacity(headerPulse ? 1.0 : 0.85)
                            .chronicleFade()
                            .accessibilityAddTraits(.isHeader)

                        SquareDivider(color: Color("Red3"))
                            .padding(.horizontal, 50)
                            .chronicleFade()

                        Text("scenariolist.subheader".localized)
                            .font(.system(.caption2, design: .monospaced).weight(.regular))
                            .foregroundColor(Color("Moss"))
                            .tracking(0.5)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .fixedSize(horizontal: false, vertical: true)
                            .italic()
                            .chronicleFade()
                    }
                    .padding(.bottom, 20)

                    // MARK: - Mission board panel
                    let isIPad = UIDevice.current.userInterfaceIdiom == .pad
                    let panelWidth = isIPad ? geo.size.width * 0.60 : geo.size.width * 0.8
                    let panelHeight: CGFloat = 380

                    let cardSquare: CGFloat = 50
                    let computedCardSize = ComponentSize.customed(width: cardSquare, height: cardSquare)

                    CustomPanel(
                        backgroundColor: Color("Beige3"),
                        size: .customed(width: panelWidth, height: panelHeight)
                    ) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color("Beige3"))
                                .frame(
                                    width: max(0, panelWidth - 5),
                                    height: max(0, panelHeight - 5)
                                )
                                .accessibilityHidden(true)
                            
                            VStack(spacing: 0) {
                                Spacer()
                                
                                VStack(spacing: 16) {
                                    // Row 1 — 3 cards
                                    HStack(spacing: 14) {
                                        ForEach(Array(row1.enumerated()), id: \.element.id) { index, scenario in
                                            BlindBoxCard(
                                                index: index,
                                                isCompleted: completedIDs.contains(scenario.id),
                                                onTap: { activeScenarioIndex = index },
                                                cardSize: computedCardSize
                                            )
                                            .staggeredAppear(delay: reduceMotion ? 0 : Double(index) * 0.12)
                                        }
                                    }
                                    
                                    // Row 2 — 2 cards, centered
                                    HStack(spacing: 14) {
                                        ForEach(Array(row2.enumerated()), id: \.element.id) { index, scenario in
                                            BlindBoxCard(
                                                index: index + 3,
                                                isCompleted: completedIDs.contains(scenario.id),
                                                onTap: { activeScenarioIndex = index + 3 },
                                                cardSize: computedCardSize
                                            )
                                            .staggeredAppear(delay: reduceMotion ? 0 : Double(index + 3) * 0.12)
                                        }
                                    }
                                }
                                
                                Spacer()
                                
                                VStack(spacing: 6) {
                                    Rectangle()
                                        .fill(Color("Red3"))
                                        .frame(height: 0.5)
                                        .padding(.horizontal, 60)
                                        .accessibilityHidden(true)
                                    
                                    Text("scenariolist.coming_soon".localized)
                                        .font(.system(.caption2, design: .monospaced).weight(.regular))
                                        .foregroundColor(Color("Moss"))
                                        .tracking(1)
                                        .italic()
                                        .padding(.vertical, 4)
                                        .accessibilityHidden(true)
                                }
                                .padding(.bottom, 12)
                            }
                        }
                    }
                    .customedBorder(
                        borderShape: "panel-border-004",
                        borderColor: Color("Moss"),
                        buttonType: .customed(width: panelWidth, height: panelHeight)
                    )
                    .accessibilityElement(children: .contain)
                    .accessibilityLabel(String(format: "scenariolist.board.a11y".localized, regionDisplayName))

                    Spacer()

                    // MARK: - Bottom actions
                    VStack(spacing: 14) {
                        DotRow(color: Color("Moss"))
                            .chronicleFade()

                        NavigationLink(destination: DiaryListView(), isActive: $navigateToDiary) {
                            EmptyView()
                        }

                        CustomButton(
                            title: "scenariolist.diary".localized,
                            textColor: Color("Beige"),
                            buttonColor: Color("Red3")
                        ) {
                            navigateToDiary = true
                        }
                        .accessibilityLabel("scenariolist.diary.a11y".localized)
                        .accessibilityHint("scenariolist.diary.a11y.hint".localized)
                        .customedBorder(
                            borderShape: "panel-border-008",
                            borderColor: Color("Gold3"),
                            buttonType: .mainButton
                        )

                        CustomButton(
                            title: "scenariolist.back".localized,
                            textColor: Color("Moss"),
                            buttonColor: Color("Beige")
                        ) {
                            dismiss()
                        }
                        .customedBorder(
                            borderShape: "panel-border-008",
                            borderColor: Color("Gold3"),
                            buttonType: .mainButton
                        )
                        .accessibilityLabel("scenariolist.back.a11y".localized)
                        .accessibilityHint("scenariolist.back.a11y.hint".localized)
                    }
                    .padding(.bottom, 36)
                }

                // MARK: - Settings Button (top right)
                SettingsButton()
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            guard !reduceMotion else { return }
            withAnimation(Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                headerPulse = true
            }
        }
    }
}

#Preview {
    NavigationStack {
        ScenarioListView(region: regions[0])
    }
}
