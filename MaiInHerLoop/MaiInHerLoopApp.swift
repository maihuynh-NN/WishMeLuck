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

    // MARK: - Persisted State
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @AppStorage("selectedAppearance") private var appearance = "system"

    // MARK: - Computed color scheme
    private var preferredColorScheme: ColorScheme? {
        switch appearance {
        case "light": return .light
        case "dark":  return .dark
        default:      return nil   // follow system
        }
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if hasSeenOnboarding {
                    HomeView()
                } else {
                    SplashScreenView()
                }
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
            .preferredColorScheme(preferredColorScheme)
        }
    }
}
