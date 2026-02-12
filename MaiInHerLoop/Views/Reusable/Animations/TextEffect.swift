//
//  Untitled.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 12/2/26.
//
import SwiftUI

struct ChronicleFadeModifier: ViewModifier {
    @State private var opacity: Double = 0
    
    func body(content: Content) -> some View {
        content
            .opacity(opacity)
            .onAppear {
                withAnimation(AppAnimations.chronicleFade.delay(0.3)) {
                    opacity = 1.0
                }
            }
    }
}

struct TypewriterModifier: ViewModifier {
    let text: String
    let speed: Double
    @State private var displayedText = ""
    @State private var currentIndex = 0
    
    func body(content: Content) -> some View {
        Text(displayedText)
            .onAppear {
                startTypewriter()
            }
    }
    
    private func startTypewriter() {
        displayedText = ""
        currentIndex = 0
        typeNextCharacter()
    }
    
    private func typeNextCharacter() {
        guard currentIndex < text.count else { return }
        
        let index = text.index(text.startIndex, offsetBy: currentIndex)
        displayedText += String(text[index])
        currentIndex += 1
        
        DispatchQueue.main.asyncAfter(deadline: .now() + speed) {
            typeNextCharacter()
        }
    }
}

struct TextHighlightModifier: ViewModifier {
    @State private var isHighlighted = false
    
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.yellow.opacity(isHighlighted ? 0.3 : 0))
            )
            .onAppear {
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
    
    func textHighlight() -> some View {
        modifier(TextHighlightModifier())
    }
    
}
