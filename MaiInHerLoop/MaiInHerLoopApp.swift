//
//  MaiInHerLoopApp.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 4/2/26.
//
import SwiftUI

@main
struct MaiInHerLoopApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if let scenario = JSONLoader.loadScenario(id: "north_easy_1") {
                    GameView(engine: ScenarioEngine(scenario: scenario))
                } else {
                    Text("Failed to load scenario")
                }
            }
            .environment(\.managedObjectContext,
                          persistenceController.container.viewContext)
        }
    }
}

