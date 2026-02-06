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
        scenarioID: String,
        snapshot: ReflectionSnapshot
    ) {
        let entry = DiaryEntry(context: context)

        entry.id = UUID()
        entry.date = Date()
        entry.scenarioID = scenarioID
        entry.archetypeID = snapshot.archetypeID
        entry.recognitionText = snapshot.recognitionText
        entry.bullets = snapshot.bullets
        entry.strength = snapshot.strength
        entry.blindSpot = snapshot.blindSpot
        entry.direction = snapshot.direction

        do {
            try context.save()
        } catch {
            print("❌ Failed to save diary entry:", error)
        }
    }
}
