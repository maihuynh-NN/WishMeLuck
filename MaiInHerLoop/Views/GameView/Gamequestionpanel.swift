//
//  GameQuestionPanel.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 21/2/26.
//

import SwiftUI

struct GameQuestionPanel: View {
    let questionText: String
    let timeRemaining: Int
    let isFirstQuestion: Bool
    let onTypingComplete: () -> Void

    @AppStorage("selectedLanguage") private var language = "en"

    // MARK: - Responsive
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    private var isWide: Bool { horizontalSizeClass == .regular }

    var body: some View {
        panelContent
    }

    private var panelContent: some View {
        VStack(alignment: .leading, spacing: 0) {

            // MARK: Top bar: decoration dots + timer
            HStack(alignment: .center) {
                // Decorative dots row (matches your existing style)
                HStack(spacing: 5) {
                    ForEach(0..<6, id: \.self) { _ in
                        Circle()
                            .fill(Color("Red3").opacity(0.5))
                            .frame(width: 3, height: 3)
                    }
                }
                .accessibilityHidden(true)

                Spacer()

                GameTimerBadge(timeRemaining: timeRemaining)
            }
            .padding(.horizontal, 14)
            .padding(.top, 10)
            .padding(.bottom, 6)

            // MARK: Divider line
            HStack {
                Rectangle()
                    .fill(Color("Red3").opacity(0.4))
                    .frame(height: 1)
                Text("◆")
                    .font(.system(size: 6))
                    .foregroundColor(Color("Red3").opacity(0.6))
                Rectangle()
                    .fill(Color("Red3").opacity(0.4))
                    .frame(height: 1)
            }
            .padding(.horizontal, 14)
            .accessibilityHidden(true)

            // MARK: Question text — typewriter, auto-height, semantic font
            Text("")
                .typewriter(questionText, speed: 0.03, onComplete: onTypingComplete)
                .font(.system(isWide ? .body : .footnote, design: .monospaced).weight(.medium))
                .foregroundColor(Color("Red3"))
                .multilineTextAlignment(.leading)
                .lineSpacing(isWide ? 4 : 3)
                // fixedSize vertical = grows to fit text, never clips or scrolls
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                // Re-trigger typewriter when question changes
                .id(questionText)
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("Beige").opacity(0.88))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("Red3").opacity(0.5), lineWidth: 1)
        )
        // Horizontal padding is handled by parent (GameView)
    }
}

// MARK: - Conditional slide-in modifier
// Applies GameStartModifier only when active = true (first question).
// For subsequent questions the panel stays in place — no re-animation.
#Preview {
    ZStack {
        Color("Beige3").ignoresSafeArea()
        GameQuestionPanel(
            questionText: "Heavy rain has been falling for 6 hours. Water levels are rising fast. What is your first action?",
            timeRemaining: 18,
            isFirstQuestion: true,
            onTypingComplete: {}
        )
        .padding(.horizontal, 24)
    }
}
