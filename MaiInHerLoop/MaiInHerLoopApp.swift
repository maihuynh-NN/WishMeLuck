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
    
    @State private var navigationPath: [AppScreen] = []

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationPath) {
                // Temporary start point - we'll change this to LanguageSelectionView in 3.2
                ScenarioListView(region: "north")
                    .navigationDestination(for: AppScreen.self) { screen in
                        destinationView(for: screen)
                    }
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
    @ViewBuilder
    private func destinationView(for screen: AppScreen) -> some View {
        switch screen {
        case .languageSelection:
            Text("Language Selection (Coming in 3.2)")
            
        case .story:
            Text("Story View (Coming in 3.3)")
            
        case .regionSelection:
            Text("Region Selection (Coming in 3.4)")
            
        case .scenarioList(let region):
            ScenarioListView(region: region)
            
        case .game(let scenario):
            GameView(engine: ScenarioEngine(scenario: scenario))
            
        case .diary:
            DiaryListView()
        }
    }
}
