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

    @State private var scenarios: [Scenario]
    @State private var textOpacity = 0.0
    @State private var headerPulse = false
    @State private var completedIDs: Set<String> = []
    @State private var navigateToDiary = false
    @State private var activeScenarioIndex: Int? = nil  // controls which NavigationLink fires

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
        ZStack {
            
            NorthernMistBackground()
            
            VStack { // needs to be in the view tree
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
                    HStack(spacing: 4) {
                        ForEach(0..<7, id: \.self) { _ in
                            Rectangle()
                                .fill(Color("Red3").opacity(0.7))
                                .frame(width: 3, height: 12)
                        }
                    }
                    .opacity(textOpacity)
                    .padding(.top, 24)

                    Text("scenariolist.header".lkey)
                        .font(.system(size: 10, weight: .bold, design: .monospaced))
                        .foregroundColor(Color("Red3").opacity(0.65))
                        .tracking(2)
                        .opacity(textOpacity)
                        .padding(.vertical, 4)

                    Text(regionDisplayName.uppercased())
                        .font(.system(size: 20, weight: .black, design: .monospaced))
                        .foregroundColor(Color("Red3"))
                        .tracking(2)
                        .opacity(headerPulse ? 1.0 : 0.85)


                    HStack {
                        Rectangle().fill(Color("Red3").opacity(0.6)).frame(height: 1)
                        Text("∎").font(.system(size: 8)).foregroundColor(Color("Red3"))
                        Rectangle().fill(Color("Red3").opacity(0.6)).frame(height: 1)
                    }

                    .padding(.horizontal, 50)
                    .opacity(textOpacity)

                    Text("scenariolist.subheader".lkey)
                        .font(.system(size: 9, weight: .light, design: .monospaced))
                        .foregroundColor(Color("Red3").opacity(0.55))
                        .tracking(0.5)
                        .italic()
                        .opacity(textOpacity)

                }
                .padding(.bottom, 30)

                // MARK: - Mission board panel
                CustomPanel(
                    backgroundColor: Color("Beige3").opacity(0.6),
                    size: .customed(width: 320, height: 220)
                ) {
                    VStack(spacing: 14) {
                        // Row 1 — 3 cards
                        HStack(spacing: 12) {
                            ForEach(Array(row1.enumerated()), id: \.element.id) { index, scenario in
                                BlindBoxCard(
                                    index: index,
                                    isCompleted: completedIDs.contains(scenario.id),
                                    onTap: {
                                        activeScenarioIndex = index  // fires the hidden NavigationLink
                                    }
                                )
                                .staggeredAppear(delay: Double(index) * 0.12)
                            }
                        }

                        // Row 2 — 2 cards, centered
                        HStack(spacing: 12) {
                            ForEach(Array(row2.enumerated()), id: \.element.id) { index, scenario in
                                BlindBoxCard(
                                    index: index + 3,
                                    isCompleted: completedIDs.contains(scenario.id),
                                    onTap: {
                                        activeScenarioIndex = index + 3
                                    }
                                )
                                .staggeredAppear(delay: Double(index + 3) * 0.12)
                            }
                        }
                    }
                }
                .customedBorder(
                    borderShape: "panel-border-030",
                    borderColor: Color("Gold3"),
                    buttonType: .customed(width: 320, height: 220)
                )

                Spacer()

                // MARK: - Bottom actions
                VStack(spacing: 14) {
                    HStack(spacing: 6) {
                        ForEach(0..<9, id: \.self) { _ in
                            Circle()
                                .fill(Color("Red3"))
                                .frame(width: 3, height: 3)
                        }
                    }
                    .opacity(textOpacity)

                    NavigationLink(destination: DiaryListView(), isActive: $navigateToDiary) {
                        EmptyView()
                    }

                    CustomButton(
                        title: "scenariolist.diary".lkey,
                        textColor: Color("Beige3"),
                        buttonColor: Color("Red")
                    ) {
                        navigateToDiary = true
                    }
                    .customedBorder(
                        borderShape: "panel-border-003",
                        borderColor: Color("Gold3"),
                        buttonType: .mainButton
                    )

                    Button(action: { dismiss() }) {
                        Text("scenariolist.back".lkey)
                            .font(.system(size: 9, weight: .light, design: .monospaced))
                            .foregroundColor(Color("Moss").opacity(0.55))
                            .tracking(0.5)
                            .underline()
                    }
                }
                .padding(.bottom, 36)
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                headerPulse = true
            }
            withAnimation(.easeIn(duration: 1.0).delay(0.4)) {
                textOpacity = 1.0
            }
        }
    }
}

#Preview {
    NavigationStack {
        ScenarioListView(region: regions[0])
    }
}
