//
//  OtherTransition.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 12/2/26.
//
import SwiftUI

extension View {
    
    func dayTransition() -> some View {
        modifier(DayTransitionModifier())
    }
    
    func gameStart() -> some View {
        modifier(GameStartModifier())
    }
    
    func gameEnd() -> some View {
        modifier(GameEndModifier())
    }
}
    struct DayTransitionModifier: ViewModifier {
        @State private var opacity: Double = 0
        @State private var scale: CGFloat = 1.5
        
        func body(content: Content) -> some View {
            content
                .opacity(opacity)
                .scaleEffect(scale)
                .onAppear {
                    withAnimation(AppAnimations.dayTransition) {
                        opacity = 1.0
                        scale = 1.0
                    }
                }
        }
    }

struct GameStartModifier: ViewModifier {
    @State private var offset: CGFloat = 50
    @State private var opacity: Double = 0
    
    func body(content: Content) -> some View {
        content
            .offset(y: offset)
            .opacity(opacity)
            .onAppear {
                withAnimation(AppAnimations.gameStart.delay(0.2)) {
                    offset = 0
                    opacity = 1.0
                }
            }
    }
}

struct GameEndModifier: ViewModifier {
    @State private var opacity: Double = 1.0
    @State private var blur: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .opacity(opacity)
            .blur(radius: blur)
            .onAppear {
                withAnimation(AppAnimations.gameEnd) {
                    opacity = 0.3
                    blur = 2
                }
            }
    }
}

