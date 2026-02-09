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
                LanguageSelectionView()  // Start here
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
            LanguageSelectionView()  
            
        case .story:
            StoryView()
            
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
