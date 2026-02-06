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

                Text("Scenario Complete")
                    .font(.title)
                    .padding()

                Text("Dominant trait: \(engine.dominantTrait())")
                    .font(.body)
            }
        }
        .padding()
    }
}

