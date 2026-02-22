//
//  GameView.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 4/2/26.
//  Rebuilt: 21/2/26
//

import SwiftUI

struct GameView: View {
    @ObservedObject var engine: ScenarioEngine
    @Environment(\.dismiss) private var dismiss

    // MARK: - Local UI state
    @State private var showBriefing = true
    @State private var isFirstQuestion = true
    @State private var showOptions = false
    @State private var selectedOptionID: String? = nil

    // Track question identity so we can reset showOptions between questions
    @State private var currentQuestionID: String = ""

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.red.opacity(0.001)
                    .ignoresSafeArea()
                    .onTapGesture {
                        print("ROOT TAP HIT")
                    }
                // MARK: Background
//                Color("Beige3")
//                    .ignoresSafeArea()

                // MARK: Door shape — always static, never animates
                doorShape(in: geo)

                // MARK: Game content inside door
                if !showBriefing {
                    gameContent(in: geo)
                }

                // MARK: Mission briefing overlay
                if showBriefing {
                    MissionBriefingOverlay(
                        scenario: engine.scenario,
                        missionIndex: engine.missionIndex,
                        onRespond: {
                            withAnimation(.easeOut(duration: 0.3)) {
                                showBriefing = false
                            }
                            engine.start()
                        },
                        onRetreat: {
                            dismiss()
                        }
                    )
                }
            }
        }
        .navigationBarHidden(true)
        // Watch for question changes to reset options visibility
        .onChange(of: engine.currentQuestion?.id) { newID in
            guard let id = newID else { return }
            if id != currentQuestionID {
                currentQuestionID = id
                showOptions = false
                selectedOptionID = nil
                // isFirstQuestion only true once per game session
            }
        }
    }

    // MARK: - Door shape

    @ViewBuilder
    private func doorShape(in geo: GeometryProxy) -> some View {
        let doorWidth = min(geo.size.width * 0.82, 380.0)
        let doorHeight = geo.size.height * 0.82

        DoorShape()
            .fill(Color.clear)          // transparent fill — image sits inside
            .frame(width: doorWidth, height: doorHeight)
            .overlay(
                // Banana leaf image clipped to door shape
                Image("BananaLeaf")
                    .resizable()
                    .scaledToFill()
                    .frame(width: doorWidth, height: doorHeight)
                    .clipShape(DoorShape())
            )
            .overlay(
                // Gold3 border
                DoorShape()
                    .stroke(Color("Gold3"), lineWidth: 3)
            )
    }

    // MARK: - Game content (question panel + option cards)

    @ViewBuilder
    private func gameContent(in geo: GeometryProxy) -> some View {
        let doorWidth = min(geo.size.width * 0.82, 380.0)
        let doorHeight = geo.size.height * 0.82
        // Horizontal padding inside the door
        let innerPadding: CGFloat = 20

        if let question = engine.currentQuestion {
            VStack(spacing: 16) {

                // MARK: Question panel
                GameQuestionPanel(
                    questionText: resolvedText(question),
                    timeRemaining: engine.timeRemaining,
                    isFirstQuestion: isFirstQuestion,
                    onTypingComplete: {
                        // Cards appear only after typewriter finishes
                        withAnimation(.easeOut(duration: 0.3)) {
                            showOptions = true
                            isFirstQuestion = false   // subsequent panels stay put
                        }
                    }
                )
                .padding(.horizontal, innerPadding)

                // MARK: Option cards 2x2 grid
                if showOptions {
                    optionGrid(question: question, innerPadding: innerPadding)
                }

                Spacer()
            }
            // Constrain content to door width
            .frame(width: doorWidth)
            // Push content down past the arch top curve (~12% of door height)
            .padding(.top, doorHeight * 0.13)

        } else if engine.isComplete {
            reflectionContent(doorWidth: doorWidth, doorHeight: doorHeight)
        }
    }

    // MARK: - Option cards grid

    @ViewBuilder
    private func optionGrid(question: Question, innerPadding: CGFloat) -> some View {
        let columns = [GridItem(.flexible(), spacing: 12),
                       GridItem(.flexible(), spacing: 12)]

        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(Array(question.options.enumerated()), id: \.element.id) { index, option in
                GameOptionCard(
                    text: resolvedOptionText(option),
                    isSelected: selectedOptionID == option.id,
                    onSelect: {
                        guard selectedOptionID == nil else { return }   // prevent double-tap
                        selectedOptionID = option.id
                        // Brief delay so "CHOSEN" state shows before transition
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
                            engine.selectOption(option)
                        }
                    }
                )
                .staggeredAppear(delay: Double(index) * 0.12)
            }
        }
        .padding(.horizontal, innerPadding)
    }

    // MARK: - Reflection (scenario complete)

    @ViewBuilder
    private func reflectionContent(doorWidth: CGFloat, doorHeight: CGFloat) -> some View {
        if let archetype = ArchetypeRepository.archetype(for: engine.dominantTrait()) {
            let snapshot = ReflectionSnapshot(
                archetypeID: archetype.id,
                recognitionText: archetype.recognitionEN,
                bullets: archetype.bulletsEN,
                strength: archetype.strengthEN,
                blindSpot: archetype.blindSpotEN,
                direction: archetype.directionEN,
                scenarioID: engine.scenarioID
            )
            ReflectionResultView(snapshot: snapshot, shouldPersist: true)
                .frame(width: doorWidth)
        } else {
            Text("Reflection unavailable")
                .foregroundColor(Color("Secondary"))
        }
    }

    // MARK: - Language helpers

    @AppStorage("selectedLanguage") private var language = "en"

    private func resolvedText(_ question: Question) -> String {
        language == "vi" ? question.textVI : question.textEN
    }

    private func resolvedOptionText(_ option: Option) -> String {
        language == "vi" ? option.textVI : option.textEN
    }
}

// MARK: - Door Shape (arch top, rectangular bottom)

struct DoorShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        // Arch radius = half the width so it forms a perfect semi-circle top
        let archRadius = rect.width / 2
        let archCenter = CGPoint(x: rect.midX, y: rect.minY + archRadius)

        // Start bottom-left
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))

        // Left side up to where arch begins
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + archRadius))

        // Arch (top semi-circle)
        path.addArc(
            center: archCenter,
            radius: archRadius,
            startAngle: .degrees(180),
            endAngle: .degrees(0),
            clockwise: false
        )

        // Right side down to bottom-right
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))

        // Bottom
        path.closeSubpath()

        return path
    }
}
// MARK: - Preview

#Preview {
    let sampleOptions = [
        Option(id: "q1_a", textEN: "Move to a higher floor immediately", textVI: "Di chuyển lên tầng cao hơn", traitTag: "than_trong", nextQuestionID: nil),
        Option(id: "q1_b", textEN: "Help neighbours evacuate first", textVI: "Giúp hàng xóm sơ tán", traitTag: "tap_the", nextQuestionID: nil),
        Option(id: "q1_c", textEN: "Document the situation on your phone", textVI: "Ghi lại tình hình", traitTag: "lac_quan", nextQuestionID: nil),
        Option(id: "q1_d", textEN: "Wait for official instructions from authorities", textVI: "Đợi hướng dẫn chính thức", traitTag: "than_trong", nextQuestionID: nil)
    ]

    let sampleQuestion = Question(
        id: "q1",
        textEN: "Water is rising fast outside your building. You have 5 minutes before the ground floor floods. What do you do first?",
        textVI: "Nước đang dâng nhanh bên ngoài tòa nhà của bạn. Bạn làm gì đầu tiên?",
        timer: 25,
        options: sampleOptions
    )

    let sampleScenario = Scenario(
        id: "north_easy_1",
        region: "north",
        titleEN: "Flash Flood in Hanoi",
        titleVI: "Lũ Quét ở Hà Nội",
        introEN: "Heavy rain has been falling for 6 hours. The streets are rising.",
        introVI: "Mưa lớn đã rơi suốt 6 giờ. Mặt đường đang dâng lên.",
        startQuestionID: "q1",
        questions: [sampleQuestion]
    )

    GameView(engine: ScenarioEngine(scenario: sampleScenario))
}
