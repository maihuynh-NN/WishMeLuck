//
//  GameView.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 4/2/26.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var engine: ScenarioEngine

    var body: some View {
        VStack(spacing: 24) {

            if let question = engine.currentQuestion {

                Text("Time remaining: \(engine.timeRemaining)")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Text(question.textEN)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding()

                ForEach(question.options, id: \.id) { option in
                    Button {
                        engine.selectOption(option)
                    } label: {
                        Text(option.textEN)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(0.15))
                            .cornerRadius(8)
                    }
                }

            } else if engine.isComplete {

                if let archetype = ArchetypeRepository.archetype(
                    for: engine.dominantTrait()
                ) {
                    let snapshot = ReflectionSnapshot(
                        archetypeID: archetype.id,
                        recognitionText: archetype.recognitionEN,
                        bullets: archetype.bulletsEN,
                        strength: archetype.strengthEN,
                        blindSpot: archetype.blindSpotEN,
                        direction: archetype.directionEN,
                        scenarioID: engine.scenarioID
                    )

                    ReflectionResultView(
                        snapshot: snapshot,
                        shouldPersist: true
                    )
                } else {
                    Text("Reflection unavailable")
                }
            }
        }
        .padding()
    }
}
#Preview("Active Question") {
    let scenario = Scenario(
        id: "preview",
        region: "north",
        titleEN: "Preview Scenario",
        titleVI: "Kịch bản xem trước",
        introEN: "This is a preview",
        introVI: "Đây là xem trước",
        startQuestionID: "q1",
        questions: [
            Question(
                id: "q1",
                textEN: "What do you do first?",
                textVI: "Bạn làm gì trước?",
                timer: 25,
                options: [
                    Option(id: "o1", textEN: "Move quickly", textVI: "Di chuyển nhanh", traitTag: "immediate_action", nextQuestionID: nil),
                    Option(id: "o2", textEN: "Check information", textVI: "Kiểm tra thông tin", traitTag: "information_first", nextQuestionID: nil)
                ]
            )
        ]
    )
    
    return GameView(engine: ScenarioEngine(scenario: scenario))
}
