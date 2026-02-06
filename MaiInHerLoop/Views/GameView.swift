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
