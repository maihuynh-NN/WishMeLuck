//
//  DiaryListView.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 6/2/26.
//

import SwiftUI
import CoreData

struct DiaryListView: View {

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \DiaryEntry.date, ascending: false)]
    )
    private var entries: FetchedResults<DiaryEntry>

    var body: some View {
        List {
            ForEach(entries) { entry in
                NavigationLink {
                    ReflectionResultView(
                        snapshot: ReflectionSnapshot(
                            archetypeID: entry.archetypeID ?? "",
                            recognitionText: entry.recognitionText ?? "",
                            bullets: entry.bullets as? [String] ?? [],
                            strength: entry.strength ?? "",
                            blindSpot: entry.blindSpot ?? "",
                            direction: entry.direction ?? "",
                            scenarioID: entry.scenarioID ?? ""
                        ),
                        shouldPersist: false
                    )
                } label: {
                    VStack(alignment: .leading) {
                        Text(entry.archetypeID ?? "Reflection")
                            .font(.headline)

                        if let date = entry.date {
                            Text(date, style: .date)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .navigationTitle("Diary")
    }
}

