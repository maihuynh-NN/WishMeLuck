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
                GameView(engine: ScenarioEngine(scenario: InitialScenario.northEasy))
            }
            .environment(\.managedObjectContext,
                          persistenceController.container.viewContext)
        }
    }
}

