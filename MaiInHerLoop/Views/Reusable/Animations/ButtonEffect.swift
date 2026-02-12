//
//  ButtonEffect.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 12/2/26.
//
import SwiftUI

struct EmergencyPulseModifier: ViewModifier {
    @State private var isPulsing = false
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isPulsing ? 1.05 : 1.0)
            .opacity(isPulsing ? 0.7 : 1.0)
            .onAppear {
                withAnimation(AppAnimations.emergencyPulse) {
                    isPulsing = true
                }
            }
    }
}

struct WarningFlashModifier: ViewModifier {
    @State private var isFlashing = false
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(isFlashing ? .orange : .yellow)
            .onAppear {
                withAnimation(AppAnimations.warningFlash) {
                    isFlashing = true
                }
            }
    }
}

extension View {
    // Emergency/Alert
    func emergencyPulse() -> some View {
        modifier(EmergencyPulseModifier())
    }
    
    func warningFlash() -> some View {
        modifier(WarningFlashModifier())
    }
    
}

