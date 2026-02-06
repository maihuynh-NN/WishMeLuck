//
//  ContentView.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 4/2/26.
//
import SwiftUI

struct ContentView: View {

    let engine: ScenarioEngine

    init() {
        guard let url = Bundle.main.url(
            forResource: "north_easy_1",
            withExtension: "json"
        ),
        let data = try? Data(contentsOf: url),
        let scenario = try? JSONDecoder().decode(Scenario.self, from: data)
        else {
            fatalError("Failed to load scenario")
        }

        self.engine = ScenarioEngine(scenario: scenario)
    }

    var body: some View {
        GameView(engine: engine)
    }
}

#Preview {
    ContentView()
}
