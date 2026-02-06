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

                Text(snapshot.recognitionText)
                    .font(.title2)

                VStack(alignment: .leading, spacing: 8) {
                    ForEach(snapshot.bullets, id: \.self) { bullet in
                        Text("• \(bullet)")
                    }
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("Strength")
                        .font(.headline)
                    Text(snapshot.strength)

                    Text("Blind Spot")
                        .font(.headline)
                    Text(snapshot.blindSpot)

                    Text("Direction")
                        .font(.headline)
                    Text(snapshot.direction)
                }
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
    }
}
