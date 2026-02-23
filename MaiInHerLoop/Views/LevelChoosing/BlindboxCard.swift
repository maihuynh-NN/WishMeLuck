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
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private let cardSize: ComponentSize = .customed(width: 68, height: 68)

    var body: some View {
        VStack(spacing: 6) {

            Button(action: onTap) {
                CustomPanel(
                    backgroundColor: isCompleted ? Color("Moss").opacity(0.55) : Color("Moss"),
                    size: cardSize
                ) {
                    ZStack {
                        
                        VStack(spacing: 8) {
                            ForEach(0..<4, id: \.self) { _ in
                                Rectangle()
                                    .fill(
                                        isCompleted
                                            ? Color("Gold3").opacity(0.06)
                                            : Color("Gold")
                                    )
                                    .frame(height: 0.5)
                            }
                        }
                        .padding(.horizontal, 8)
                        .accessibilityHidden(true)

                        VStack(spacing: 5) {
                            // Number
                            Text(String(format: "%02d", index + 1))
                                .font(.system(.title2, design: .monospaced).weight(.black))
                                .foregroundColor(
                                    isCompleted
                                        ? Color("Gold").opacity(0.3)
                                        : Color("Gold").opacity(pulse ? 1.0 : 0.8)
                                )
                                .tracking(3)
                                .accessibilityHidden(true)

                            // Dot row — decorative ornament
                            HStack(spacing: 4) {
                                Rectangle()
                                    .fill(isCompleted ? Color("Gold").opacity(0.15) : Color("Gold").opacity(0.35))
                                    .frame(width: 12, height: 0.5)
                                Circle()
                                    .fill(isCompleted ? Color("Gold").opacity(0.2) : Color("Gold").opacity(0.5))
                                    .frame(width: 2.5, height: 2.5)
                                Rectangle()
                                    .fill(isCompleted ? Color("Gold").opacity(0.15) : Color("Gold").opacity(0.35))
                                    .frame(width: 12, height: 0.5)
                            }
                            .accessibilityHidden(true)
                        }
                    }
                }
            }
            .accessibilityLabel("Mission \(index + 1), \(isCompleted ? "completed" : "locked")")
            .accessibilityHint(isCompleted ? "Double tap to replay" : "Double tap to start this mission")
            .customedBorder(
                borderShape: "panel-border-003",
                borderColor: isCompleted ? Color("Gold").opacity(0.2) : Color("Gold").opacity(pulse ? 0.9 : 0.65),
                buttonType: cardSize
            )

            // MARK: - Label below card
            Text(isCompleted ? "mission.responded".lkey : "mission.classified".lkey)
                .font(.system(.caption2, design: .monospaced).weight(.medium))
                .foregroundColor(
                    isCompleted
                        ? Color("Gold").opacity(0.3)
                        : Color("Gold").opacity(0.55)
                )
                .tracking(0.5)
                .lineLimit(1)
                .accessibilityHidden(true) 
        }
        .onAppear {
            guard !reduceMotion else { return }
            withAnimation(
                Animation.easeInOut(duration: 2.0)
                    .repeatForever(autoreverses: true)
                    .delay(Double(index) * 0.3)
            ) {
                pulse = true
            }
        }
    }
}

#Preview {
    ZStack {
        Color("Background").ignoresSafeArea()
        VStack(spacing: 14) {
            HStack(spacing: 14) {
                BlindBoxCard(index: 0, isCompleted: false, onTap: {})
                BlindBoxCard(index: 1, isCompleted: true, onTap: {})
                BlindBoxCard(index: 2, isCompleted: false, onTap: {})
            }
            HStack(spacing: 14) {
                BlindBoxCard(index: 3, isCompleted: false, onTap: {})
                BlindBoxCard(index: 4, isCompleted: true, onTap: {})
            }
        }
    }
}
