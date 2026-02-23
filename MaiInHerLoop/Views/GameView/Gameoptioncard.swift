//
//  GameOptionCard.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 21/2/26.
//

import SwiftUI

/// One option card in the 2×2 grid.
/// Single tap → bounce (CardSelectModifier) → fires onSelect.
/// isSelected state shows "CHOSEN" state briefly.
struct GameOptionCard: View {
    let text: String
    let isSelected: Bool
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            VStack(spacing: 0) {

                // Arrow row decoration (matches your existing CardView style)
                HStack {
                    Spacer()
                    HStack(spacing: 2) {
                        ForEach(0..<5, id: \.self) { _ in
                            Image(systemName: "chevron.right")
                                .font(.system(size: 4, weight: .bold))
                                .foregroundColor(isSelected ? Color("Gold").opacity(0.7) : Color("Moss").opacity(0.5))
                        }
                    }
                }
                .padding(.top, 8)
                .padding(.trailing, 10)

                Spacer(minLength: 4)

                // Option text — auto-sizes, no clipping
                Text(text)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(isSelected ? Color("Gold") : Color("Moss"))
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 10)

                Spacer(minLength: 4)

                // Bottom label
                if isSelected {
                    Text("CHOSEN")
                        .font(.system(size: 8, weight: .black, design: .monospaced))
                        .foregroundColor(Color("Gold"))
                        .tracking(1)
                        .padding(.bottom, 6)
                } else {
                    // Decorative divider
                    HStack(spacing: 3) {
                        Rectangle()
                            .fill(Color("Moss").opacity(0.5))
                            .frame(height: 1)
                        Text("◆")
                            .font(.system(size: 4))
                            .foregroundColor(Color("Moss").opacity(0.6))
                        Rectangle()
                            .fill(Color("Moss").opacity(0.5))
                            .frame(height: 1)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 8)
                }
            }
            // Height is flexible — grows with text content
            .frame(maxWidth: .infinity, minHeight: 80)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(isSelected ? Color("Moss") : Color("Gold").opacity(0.9))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(
                        isSelected ? Color("Red").opacity(0.6) : Color("Red").opacity(0.5),
                        lineWidth: 1
                    )
            )
            .scaleEffect(isSelected ? 0.96 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: isSelected)
        }
        .buttonStyle(CardTapStyle())   // handles the CardSelectModifier bounce on tap
    }
}

// MARK: - Button style that applies CardSelectModifier bounce
private struct CardTapStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.92 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

#Preview {
    HStack(spacing: 12) {
        GameOptionCard(
            text: "Move to a higher floor immediately",
            isSelected: false,
            onSelect: {}
        )
        GameOptionCard(
            text: "Help neighbours evacuate first",
            isSelected: true,
            onSelect: {}
        )
    }
    .padding(.top, 20)
    .background(Color("Beige3"))
}
