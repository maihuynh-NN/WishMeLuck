//
//  BlindBoxCard.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 18/2/26.
//

import SwiftUI

struct BlindBoxCard: View {
    let index: Int
    let isCompleted: Bool
    let onTap: () -> Void

    @State private var pulse = false

    private let cardSize: ComponentSize = .customed(width: 60, height: 60)

    var body: some View {
        Button(action: onTap) {
            CustomPanel(
                backgroundColor: isCompleted ? Color("Moss").opacity(0.25) : Color("Moss"),
                size: cardSize
            ) {
                VStack(spacing: 6) {
                    Text(String(format: "%02d", index + 1))
                        .font(.system(size: 22, weight: .black, design: .monospaced))
                        .foregroundColor(isCompleted ? Color("Gold").opacity(0.35) : Color("Gold"))
                        .tracking(2)
                        .opacity(pulse ? 1.0 : 0.75)

                    HStack(spacing: 3) {
                        ForEach(0..<3, id: \.self) { _ in
                            Circle()
                                .fill(isCompleted ? Color("Gold").opacity(0.3) : Color("Gold").opacity(0.6))
                                .frame(width: 3, height: 3)
                        }
                    }

                    Text(isCompleted ? "mission.responded".lkey : "mission.classified".lkey)
                        .font(.system(size: 7, weight: .medium, design: .monospaced))
                        .foregroundColor(isCompleted ? Color("Gold").opacity(0.3) : Color("Gold").opacity(0.65))
                        .tracking(0.3)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .frame(maxWidth: 70)
                }
            }
        }
        .customedBorder(
            borderShape: "panel-border-003",
            borderColor: isCompleted ? Color("Gold").opacity(0.25) : Color("Gold"),
            buttonType: cardSize
        )
        .onAppear {
            withAnimation(
                Animation.easeInOut(duration: 1.8)
                    .repeatForever(autoreverses: true)
                    .delay(Double(index) * 0.25)
            ) {
                pulse = true
            }
        }
    }
}

#Preview {
    ZStack {
        Color("Background").ignoresSafeArea()
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                BlindBoxCard(index: 0, isCompleted: false, onTap: {})
                BlindBoxCard(index: 1, isCompleted: true, onTap: {})
                BlindBoxCard(index: 2, isCompleted: false, onTap: {})
            }
            HStack(spacing: 12) {
                BlindBoxCard(index: 3, isCompleted: false, onTap: {})
                BlindBoxCard(index: 4, isCompleted: true, onTap: {})
            }
        }
    }
}
