import SwiftUI

// MARK: - Animation Library
struct AppAnimations {
    // Core timing constants
    static let fastTiming: Double = 0.3
    static let mediumTiming: Double = 0.6
    static let slowTiming: Double = 1.2
    static let typewriterSpeed: Double = 0.05
    static let textHighlight = Animation.easeInOut(duration: 0.4)
    
    // Button animations
    static let emergencyPulse = Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true)
    static let warningFlash = Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true)
    
    // Card animations
    static let cardSelect = Animation.easeOut(duration: 0.2)
    static let cardSubmit = Animation.easeInOut(duration: 0.5)
    
    // Overlay animations
    static let overlayFade = Animation.easeInOut(duration: fastTiming)
    static let modalSlide = Animation.easeOut(duration: mediumTiming)
    static let panelExpand = Animation.easeOut(duration: 0.4)
    
    // Medieval effects
    static let chronicleFade = Animation.easeIn(duration: 0.8)
    static let textSlide = Animation.easeOut(duration: 0.7)
    
    // Game state transitions
    static let dayTransition = Animation.easeInOut(duration: 1.0)
    static let gameStart = Animation.easeOut(duration: 0.8)
    static let gameEnd = Animation.easeIn(duration: 1.0)

}
