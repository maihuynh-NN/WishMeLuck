//
//  MaiInHerLoopApp.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 4/2/26.
//
import SwiftUI

@main
struct MaiInHerLoopApp: App {

    init() {
        loadAndTestScenario()
    }

    var body: some Scene {
        WindowGroup {
            Text("Engine Test")
        }
    }

    private func loadAndTestScenario() {
        guard let url = Bundle.main.url(
            forResource: "north_easy_1",
            withExtension: "json",
        ) else {
            print("❌ JSON file not found (no subdirectory)")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let scenario = try JSONDecoder().decode(Scenario.self, from: data)

            print("✅ Scenario loaded:", scenario.titleEN)

            let engine = ScenarioEngine(scenario: scenario)

            print("➡️ First question:", engine.currentQuestion?.textEN ?? "nil")

            // Simulate answering first option
            if let option = engine.currentQuestion?.options.first {
                engine.selectOption(option)
                print("➡️ Next question:", engine.currentQuestion?.textEN ?? "end")
            }

            // Simulate final answer
            if let option = engine.currentQuestion?.options.first {
                engine.selectOption(option)
            }

            print("🏁 Complete:", engine.isComplete)
            print("🧠 Dominant trait:", engine.dominantTrait())

        } catch {
            print("❌ Decode error:", error)
        }
    }
}


