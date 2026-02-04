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
        if let url = Bundle.main.url(forResource: "north_easy_1", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let scenario = try JSONDecoder().decode(Scenario.self, from: data)
                print("Loaded scenario:", scenario.titleEN)
                print("First question:", scenario.questions.first?.textEN ?? "")
            } catch {
                print("JSON error:", error)
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


