//
//  ReflectionResultView.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 4/2/26.
//
import SwiftUI

struct ReflectionResultView: View {
    let snapshot: ReflectionSnapshot

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                Text(snapshot.recognitionText)
                    .font(.title2)
                    .padding(.top)

                VStack(alignment: .leading, spacing: 8) {
                    ForEach(snapshot.bullets, id: \.self) { bullet in
                        Text("• \(bullet)")
                    }
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("Strength").font(.headline)
                    Text(snapshot.strength)

                    Text("Blind Spot").font(.headline)
                    Text(snapshot.blindSpot)

                    Text("Direction").font(.headline)
                    Text(snapshot.direction)
                }
            }
            .padding()
        }
        
    }
}
