//
//  ReflectionResultView.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 4/2/26.
//
import SwiftUI

struct ReflectionResultView: View {
    @Environment(\.managedObjectContext) private var context

    let snapshot: ReflectionSnapshot
    let shouldPersist: Bool

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                
                // Archetype icon + name
                HStack(spacing: 12) {
                    if let archetype = ArchetypeRepository.archetype(for: snapshot.archetypeID) {
                        Image(systemName: archetype.imageName)
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                        
                        VStack(alignment: .leading) {
                            Text(archetype.nameEN)
                                .font(.title2.bold())
                            Text(archetype.definitionEN)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(.bottom, 8)
                
                Divider()

                // Recognition
                Text(snapshot.recognitionText)
                    .font(.title3)
                    .fontWeight(.medium)

                // Behavioral bullets
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(snapshot.bullets, id: \.self) { bullet in
                        HStack(alignment: .top) {
                            Text("•")
                            Text(bullet)
                        }
                    }
                }
                .padding(.vertical, 8)

                // Psychological mirror
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 4) {
                        Label("This helps when", systemImage: "checkmark.circle.fill")
                            .font(.headline)
                            .foregroundColor(.green)
                        Text(snapshot.strength)
                            .foregroundColor(.secondary)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Label("Watch out when", systemImage: "exclamationmark.triangle.fill")
                            .font(.headline)
                            .foregroundColor(.orange)
                        Text(snapshot.blindSpot)
                            .foregroundColor(.secondary)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Label("Going forward", systemImage: "arrow.forward.circle.fill")
                            .font(.headline)
                            .foregroundColor(.blue)
                        Text(snapshot.direction)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.vertical, 8)
            }
            .padding()
            .onAppear {
                if shouldPersist {
                    DiaryStore.save(
                        context: context,
                        snapshot: snapshot
                    )
                }
            }
        }
        .navigationTitle("Reflection")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview("Self Reliance") {
    ReflectionResultView(
        snapshot: ReflectionSnapshot(
            archetypeID: "self_reliance",
            recognitionText: "You trusted your own judgment and acted without waiting for direction.",
            bullets: [
                "You relied on personal assessment",
                "You stayed active while others waited"
            ],
            strength: "Systems fail, communication breaks, or help arrives late.",
            blindSpot: "Shared decisions reduce risk better than acting alone.",
            direction: "Your self-sufficiency is a resource others can learn from.",
            scenarioID: "north_easy_1"
        ),
        shouldPersist: false
    )
}
