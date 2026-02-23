//
//  ScenarioListView.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 9/2/26.
//

import SwiftUI

struct ScenarioListView: View {
    let region: Region

    @AppStorage("selectedLanguage") private var language = "en"
    @Environment(\.dismiss) private var dismiss
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @State private var scenarios: [Scenario]
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
                Color("Beige3").ignoresSafeArea()

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
                        // Decorative bar — hidden from VoiceOver
                        HStack(spacing: 4) {
                            ForEach(0..<7, id: \.self) { _ in
                                Rectangle()
                                    .fill(Color("Red3").opacity(0.7))
                                    .frame(width: 3, height: 12)
                            }
                        }
                        .accessibilityHidden(true)
                        .chronicleFade()
                        .padding(.top, 24)

                        Text("scenariolist.header".lkey)
                            .font(.system(.caption2, design: .monospaced).weight(.bold))
                            .foregroundColor(Color("Red3").opacity(0.65))
                            .tracking(2)
                            .chronicleFade()
                            .padding(.vertical, 4)

                        Text(regionDisplayName.uppercased())
                            .font(.system(.title3, design: .monospaced).weight(.black))
                            .foregroundColor(Color("Red3"))
                            .tracking(2)
                            .opacity(headerPulse ? 1.0 : 0.85)
                            .chronicleFade()

                        // Decorative divider — hidden from VoiceOver
                        HStack {
                            Rectangle().fill(Color("Red3").opacity(0.6)).frame(height: 1)
                            Text("∎").font(.system(size: 8)).foregroundColor(Color("Red3"))
                            Rectangle().fill(Color("Red3").opacity(0.6)).frame(height: 1)
                        }
                        .padding(.horizontal, 50)
                        .chronicleFade()
                        .accessibilityHidden(true)

                        Text("scenariolist.subheader".lkey)
                            .font(.system(.caption2, design: .monospaced).weight(.light))
                            .foregroundColor(Color("Red3").opacity(0.55))
                            .tracking(0.5)
                            .italic()
                            .chronicleFade()
                    }
                    .padding(.bottom, 30)

                    // MARK: - Mission board panel
                    // Width adapts to screen: 92% of screen width, capped at 400
                    let panelWidth = min(geo.size.width * 0.92, 400)
                    let panelHeight: CGFloat = 260

                    CustomPanel(
                        backgroundColor: Color("Beige3").opacity(0.6),
                        size: .customed(width: panelWidth, height: panelHeight)
                    ) {
                        VStack(spacing: 0) {
                            Spacer()

                            VStack(spacing: 16) {
                                // Row 1 — 3 cards
                                HStack(spacing: 14) {
                                    ForEach(Array(row1.enumerated()), id: \.element.id) { index, scenario in
                                        BlindBoxCard(
                                            index: index,
                                            isCompleted: completedIDs.contains(scenario.id),
                                            onTap: {
                                                activeScenarioIndex = index
                                            }
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
                                            onTap: {
                                                activeScenarioIndex = index + 3
                                            }
                                        )
                                        .staggeredAppear(delay: reduceMotion ? 0 : Double(index + 3) * 0.12)
                                    }
                                }
                            }

                            Spacer()

                            // ── Coming soon footer ─────────────────────────
                            VStack(spacing: 6) {
                                Rectangle()
                                    .fill(Color("Gold3").opacity(0.35))
                                    .frame(height: 0.5)
                                    .padding(.horizontal, 20)
                                    .accessibilityHidden(true)

                                Text("· more scenarios coming soon ·")
                                    .font(.system(.caption2, design: .monospaced).weight(.light))
                                    .foregroundColor(Color("Gold3").opacity(0.5))
                                    .tracking(1)
                                    .italic()
                                    .accessibilityHidden(true) // not actionable info
                            }
                            .padding(.bottom, 12)
                        }
                    }
                    .customedBorder(
                        borderShape: "panel-border-030",
                        borderColor: Color("Gold3"),
                        buttonType: .customed(width: panelWidth, height: panelHeight)
                    )
                    // Accessibility group: the whole board described as a unit
                    .accessibilityElement(children: .contain)
                    .accessibilityLabel("Mission board for \(regionDisplayName)")

                    Spacer()

                    // MARK: - Bottom actions
                    VStack(spacing: 14) {
                        // Decorative dots — hidden from VoiceOver
                        HStack(spacing: 6) {
                            ForEach(0..<9, id: \.self) { _ in
                                Circle()
                                    .fill(Color("Red3"))
                                    .frame(width: 3, height: 3)
                            }
                        }
                        .accessibilityHidden(true)
                        .chronicleFade()

                        NavigationLink(destination: DiaryListView(), isActive: $navigateToDiary) {
                            EmptyView()
                        }

                        CustomButton(
                            title: "scenariolist.diary".localized,
                            textColor: Color("Beige3"),
                            buttonColor: Color("Red")
                        ) {
                            navigateToDiary = true
                        }
                        .accessibilityLabel("Open diary")
                        .accessibilityHint("View your reflections from completed missions")
                        .customedBorder(
                            borderShape: "panel-border-003",
                            borderColor: Color("Gold3"),
                            buttonType: .mainButton
                        )

                        Button(action: { dismiss() }) {
                            Text("scenariolist.back".lkey)
                                .font(.system(.caption2, design: .monospaced).weight(.light))
                                .foregroundColor(Color("Moss").opacity(0.55))
                                .tracking(0.5)
                                .underline()
                        }
                        .accessibilityLabel("Go back")
                        .accessibilityHint("Return to region selection")
                    }
                    .padding(.bottom, 36)
                }
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
