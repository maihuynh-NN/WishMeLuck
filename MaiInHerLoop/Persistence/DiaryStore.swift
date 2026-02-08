//
//  DiaryStore.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 6/2/26.
//

import CoreData

final class DiaryStore {

    static func save(
        context: NSManagedObjectContext,
        snapshot: ReflectionSnapshot
    ) {
        let entry = DiaryEntry(context: context)

        entry.id = UUID()
        entry.date = Date()
        entry.scenarioID = snapshot.scenarioID
        entry.archetypeID = snapshot.archetypeID
        entry.recognitionText = snapshot.recognitionText
        entry.bullets = snapshot.bullets as NSArray
        entry.strength = snapshot.strength
        entry.blindSpot = snapshot.blindSpot
        entry.direction = snapshot.direction
        print("🟢 SAVE CALLED for scenario:", snapshot.scenarioID)
        do {
            try context.save()
            debugPrintLatestEntry(context: context)
        } catch {
            print("❌ Failed to save diary entry:", error)
        }
    }
    
    static func debugPrintLatestEntry(context: NSManagedObjectContext) {
        let request: NSFetchRequest<DiaryEntry> = DiaryEntry.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \DiaryEntry.date, ascending: false)]
        request.fetchLimit = 1

        do {
            if let entry = try context.fetch(request).first {
                print("📘 DIARY DEBUG FETCH")
                print("scenarioID:", entry.scenarioID ?? "nil")
                print("archetypeID:", entry.archetypeID ?? "nil")
                print("recognitionText:", entry.recognitionText ?? "nil")
                print("bullets count:", (entry.bullets as? [String])?.count ?? -1)
                print("strength:", entry.strength ?? "nil")
                print("blindSpot:", entry.blindSpot ?? "nil")
                print("direction:", entry.direction ?? "nil")
                print("date:", entry.date ?? Date.distantPast)
            } else {
                print("📕 DIARY DEBUG FETCH – no entries found")
            }
        } catch {
            print("❌ DIARY DEBUG FETCH failed:", error)
        }
    }

}
