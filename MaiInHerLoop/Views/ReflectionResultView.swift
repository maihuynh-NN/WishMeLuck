//
//  ReflectionResultView.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 4/2/26.
//
import SwiftUI

struct ReflectionResultView: View {

    let archetype: Archetype

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                Text(archetype.recognitionEN)
                    .font(.title2)
                    .padding(.top)

                Text(archetype.nameEN)
                    .font(.headline)

                VStack(alignment: .leading, spacing: 8) {
                    ForEach(archetype.bulletsEN, id: \.self) { bullet in
                        Text("• \(bullet)")
                    }
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("Strength")
                        .font(.headline)
                    Text(archetype.strengthEN)

                    Text("Blind Spot")
                        .font(.headline)
                    Text(archetype.blindSpotEN)

                    Text("Direction")
                        .font(.headline)
                    Text(archetype.directionEN)
                }
            }
            .padding()
        }
    }
}
