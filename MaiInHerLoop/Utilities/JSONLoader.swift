//
//  JSONLoader.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 4/2/26.
//
import Foundation

enum JSONLoader {
    static func loadScenario(id: String) -> Scenario? {
        guard let url = Bundle.main.url(
            forResource: id,
            withExtension: "json"
        ) else {
            print("❌ Scenario file not found: \(id).json")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let scenario = try JSONDecoder().decode(Scenario.self, from: data)
            return scenario
        } catch {
            print("❌ Failed to decode scenario: \(error)")
            return nil
        }
    }
}
