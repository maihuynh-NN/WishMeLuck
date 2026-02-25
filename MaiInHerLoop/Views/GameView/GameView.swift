import SwiftUI

struct GameView: View {
    @ObservedObject var engine: ScenarioEngine
    @Environment(\.dismiss) private var dismiss

    @State private var showBriefing = true
    @State private var isFirstQuestion = true
    @State private var showOptions = false
    @State private var selectedOptionID: String? = nil
    @State private var currentQuestionID: String = ""
    @State private var panelHeight: CGFloat = 0

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color("Beige3").ignoresSafeArea()
                doorShape(in: geo)

                if !showBriefing {
                    gameContent(in: geo)
                }

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
                        onRetreat: { dismiss() }
                    )
                }
            }
        }
        .navigationBarHidden(true)
        .onChange(of: engine.currentQuestion?.id) { newID in
            guard let id = newID, id != currentQuestionID else { return }
            currentQuestionID = id
            showOptions = false
            selectedOptionID = nil
        }
    }

    // MARK: - Door shape

    @ViewBuilder
    private func doorShape(in geo: GeometryProxy) -> some View {
        let doorWidth = min(geo.size.width * 0.82, 380.0)
        let doorHeight = geo.size.height * 0.82

        DoorShape()
            .fill(Color.clear)
            .frame(width: doorWidth, height: doorHeight)
            .overlay(
                Image("BananaLeaf")
                    .resizable()
                    .scaledToFill()
                    .frame(width: doorWidth, height: doorHeight)
                    .clipShape(DoorShape())
            )
            .overlay(
                DoorShape().stroke(Color("Gold3"), lineWidth: 4)
            )
    }

    // MARK: - Game content

    @ViewBuilder
    private func gameContent(in geo: GeometryProxy) -> some View {
        let doorWidth = min(geo.size.width * 0.82, 380.0)
        let doorHeight = geo.size.height * 0.82
        let innerPadding: CGFloat = 16

        let doorTop = (geo.size.height - doorHeight) / 2
        let archBottom = doorTop + (doorWidth / 2)
        let questionPanelTopY = archBottom + 70

        if let question = engine.currentQuestion {
            let doorCenterX = geo.size.width / 2

            ZStack(alignment: .top) {

                GameQuestionPanel(
                    questionText: resolvedText(question),
                    timeRemaining: engine.timeRemaining,
                    isFirstQuestion: isFirstQuestion,
                    onTypingComplete: {
                        withAnimation(.easeOut(duration: 0.4)) {
                            showOptions = true
                            isFirstQuestion = false
                        }
                    }
                )
                .padding(.horizontal, innerPadding)
                .frame(width: doorWidth)
                .id(question.id)
                .offset(y: questionPanelTopY)
                .background(
                    GeometryReader { g in
                        Color.clear
                            .onAppear { panelHeight = g.size.height }
                            .onChange(of: g.size.height) { panelHeight = $0 }
                    }
                    .offset(y: questionPanelTopY)
                )

                if showOptions {
                    optionGrid(question: question, innerPadding: innerPadding)
                        .frame(width: doorWidth)
                        .offset(y: questionPanelTopY + panelHeight + 16)
                        .transition(.opacity.combined(with: .move(edge: .bottom)))
                }
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .top)
            .position(x: doorCenterX, y: geo.size.height / 2)
            .animation(nil, value: showOptions)

        } else if engine.isComplete {
            reflectionContent(doorWidth: doorWidth, doorHeight: doorHeight)
        }
    }

    // MARK: - Option grid

    @ViewBuilder
    private func optionGrid(question: Question, innerPadding: CGFloat) -> some View {
        let columns = [GridItem(.flexible(), spacing: 10),
                       GridItem(.flexible(), spacing: 10)]

        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(Array(question.options.enumerated()), id: \.element.id) { index, option in
                GameOptionCard(
                    text: resolvedOptionText(option),
                    isSelected: selectedOptionID == option.id,
                    onSelect: {
                        guard selectedOptionID == nil else { return }
                        selectedOptionID = option.id
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

    // MARK: - Reflection

    @ViewBuilder
    private func reflectionContent(doorWidth: CGFloat, doorHeight: CGFloat) -> some View {
        if let archetype = ArchetypeRepository.archetype(for: engine.dominantTrait()) {
            let snapshot = ReflectionSnapshot(
                archetypeID: archetype.id,
                recognitionText: "",
                bullets: [],
                strength: "",
                blindSpot: "",
                direction: "",
                scenarioID: engine.scenarioID
            )
            ReflectionResultView(
                snapshot: snapshot,
                shouldPersist: true,
                onGoToDiary: { /* TODO: navigate to DiaryListView */ },
                onGoToScenarios: { dismiss() }
            )
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

// MARK: - Door Shape

struct DoorShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let archRadius = rect.width / 2
        let archCenter = CGPoint(x: rect.midX, y: rect.minY + archRadius)
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + archRadius))
        path.addArc(center: archCenter, radius: archRadius,
                    startAngle: .degrees(180), endAngle: .degrees(0), clockwise: false)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
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
        textEN: "Water is rising fast outside your building. What do you do first? Water is rising fast outside your building. What do you do first? Water is rising fast outside your building. What do you do first?",
        textVI: " Bạn làm gì đầu tiên? Bạn làm gì đầu tiên? Nước đang dâng nhanh bên ngoài tòa nhà của bạn. Bạn làm gì đầu tiên? ",
        timer: 25, options: sampleOptions
    )
    let sampleScenario = Scenario(
        id: "north_easy_1", region: "north",
        titleEN: "Flash Flood in Hanoi", titleVI: "Lũ Quét ở Hà Nội",
        introEN: "Heavy rain has been falling for 6 hours.",
        introVI: "Mưa lớn đã rơi suốt 6 giờ.",
        startQuestionID: "q1", questions: [sampleQuestion]
    )
    GameView(engine: ScenarioEngine(scenario: sampleScenario))
}
