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
        entry.id         = UUID()
        entry.date       = Date()
        entry.scenarioID = snapshot.scenarioID
        entry.archetypeID = snapshot.archetypeID

        do {
            try context.save()
            print("🟢 Diary saved — scenario: \(snapshot.scenarioID), archetype: \(snapshot.archetypeID)")
        } catch {
            print("❌ Diary save failed: \(error)")
        }
    }
}
