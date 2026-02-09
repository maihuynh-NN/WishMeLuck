//
//  JSONLoader.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 4/2/26.
//
import Foundation

enum JSONLoader {
    static func loadScenario(id: String) -> Scenario? {
        print("🔍 Attempting to load: \(id)")
        
        guard let url = Bundle.main.url(
            forResource: id,
            withExtension: "json"
        ) else {
            print("❌ File not found in bundle: \(id).json")
            return nil
        }
        
        print("✅ Found file at: \(url.path)")
        
        do {
            let data = try Data(contentsOf: url)
            print("✅ Loaded data, size: \(data.count) bytes")
            
            let scenario = try JSONDecoder().decode(Scenario.self, from: data)
            print("✅ Successfully decoded scenario: \(scenario.id)")
            return scenario
        } catch let DecodingError.keyNotFound(key, context) {
            print("❌ Missing key: \(key.stringValue)")
            print("   Context: \(context.debugDescription)")
            return nil
        } catch let DecodingError.typeMismatch(type, context) {
            print("❌ Type mismatch for type: \(type)")
            print("   Context: \(context.debugDescription)")
            return nil
        } catch {
            print("❌ Failed to decode: \(error)")
            return nil
        }
    }
}
