//
//  TextEffect.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 12/2/26.
//
import SwiftUI

// MARK: - Chronicle Fade
struct ChronicleFadeModifier: ViewModifier {
    @State private var opacity: Double = 0
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View {
        content
            .opacity(opacity)
            .onAppear {
                if reduceMotion {
                    opacity = 1.0
                    return
                }
                withAnimation(AppAnimations.chronicleFade.delay(0.3)) {
                    opacity = 1.0
                }
            }
    }
}

// MARK: - Typewriter
// If reduceMotion is on, text appears instantly and onComplete fires immediately.
struct TypewriterModifier: ViewModifier {
    let text: String
    let speed: Double
    var onComplete: (() -> Void)? = nil

    @State private var displayedText = ""
    @State private var currentIndex = 0
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View {
        Text(displayedText)
            .onAppear {
                startTypewriter()
            }
            .onChange(of: text) { newText in
                restartTypewriter(for: newText)
            }
    }

    private func startTypewriter() {
        if reduceMotion {
            displayedText = text
            onComplete?()
            return
        }
        displayedText = ""
        currentIndex = 0
        typeNextCharacter()
    }

    private func restartTypewriter(for newText: String) {
        displayedText = ""
        currentIndex = 0
        if reduceMotion {
            displayedText = newText
            onComplete?()
            return
        }
        typeNextCharacter()
    }

    private func typeNextCharacter() {
        guard currentIndex < text.count else {
            onComplete?()
            return
        }
        let index = text.index(text.startIndex, offsetBy: currentIndex)
        displayedText += String(text[index])
        currentIndex += 1

        DispatchQueue.main.asyncAfter(deadline: .now() + speed) {
            typeNextCharacter()
        }
    }
}

// MARK: - Text Highlight
struct TextHighlightModifier: ViewModifier {
    @State private var isHighlighted = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.yellow.opacity(isHighlighted ? 0.3 : 0))
            )
            .onAppear {
                if reduceMotion {
                    isHighlighted = true
                    return
                }
                withAnimation(AppAnimations.textHighlight) {
                    isHighlighted = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation(AppAnimations.textHighlight) {
                        isHighlighted = false
                    }
                }
            }
    }
}

// MARK: - View Extensions
extension View {
    func chronicleFade() -> some View {
        modifier(ChronicleFadeModifier())
    }

    func typewriter(_ text: String, speed: Double = AppAnimations.typewriterSpeed) -> some View {
        modifier(TypewriterModifier(text: text, speed: speed))
    }

    func typewriter(
        _ text: String,
        speed: Double = AppAnimations.typewriterSpeed,
        onComplete: @escaping () -> Void
    ) -> some View {
        modifier(TypewriterModifier(text: text, speed: speed, onComplete: onComplete))
    }

    func textHighlight() -> some View {
        modifier(TextHighlightModifier())
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: 24) {
        Text("Chronicle Fade")
            .font(.title2)
            .chronicleFade()

        Text("")
            .typewriter("Typewriter effect — character by character.")

        Text("Highlighted text")
            .textHighlight()
    }
    .padding()
}
