//
//  GameTimerBadge.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 21/2/26.
//

import SwiftUI

// Small timer badge shown in the top-right corner of the question panel.
// Color shifts green → orange → red as time runs low.
// WarningFlashModifier activates at ≤10 seconds.
struct GameTimerBadge: View {
    let timeRemaining: Int

    private var badgeColor: Color {
        if timeRemaining <= 10 { return Color("Red2") }
        if timeRemaining <= 20 { return Color("Gold2") }
        return Color("Moss")
    }

    private var isUrgent: Bool { timeRemaining <= 10 }

    var body: some View {
        Text("\(timeRemaining)s")
            .font(.system(.caption2, design: .monospaced).weight(.black))
            .foregroundColor(Color("Beige3"))
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(badgeColor.opacity(0.85))
            )
            // Only apply flash when urgent — avoids perpetual animation overhead
            .modifier(TimerFlashModifier(active: isUrgent))
    }
}

// Conditionally applies WarningFlashModifier logic.
// Defined here to keep GameTimerBadge self-contained.
private struct TimerFlashModifier: ViewModifier {
    let active: Bool
    @State private var isFlashing = false

    func body(content: Content) -> some View {
        content
            .opacity(active ? (isFlashing ? 0.55 : 1.0) : 1.0)
            .onAppear {
                guard active else { return }
                withAnimation(AppAnimations.warningFlash) {
                    isFlashing = true
                }
            }
            .onChange(of: active) { nowActive in
                if nowActive {
                    withAnimation(AppAnimations.warningFlash) {
                        isFlashing = true
                    }
                } else {
                    isFlashing = false
                }
            }
    }
}

#Preview {
    HStack(spacing: 16) {
        GameTimerBadge(timeRemaining: 25)
        GameTimerBadge(timeRemaining: 15)
        GameTimerBadge(timeRemaining: 7)
    }
    .padding()
    .background(Color("Parchment"))
}
