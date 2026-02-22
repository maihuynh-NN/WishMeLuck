//
//  TextEffect.swift
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

// MARK: - Typewriter — now has optional onComplete callback
struct TypewriterModifier: ViewModifier {
    let text: String
    let speed: Double
    var onComplete: (() -> Void)? = nil

    @State private var displayedText = ""
    @State private var currentIndex = 0

    func body(content: Content) -> some View {
        Text(displayedText)
            .onAppear {
                startTypewriter()
            }
            // Re-run when text changes (new question loaded)
            .onChange(of: text) { newText in
                restartTypewriter(for: newText)
            }
    }

    private func startTypewriter() {
        displayedText = ""
        currentIndex = 0
        typeNextCharacter()
    }

    private func restartTypewriter(for newText: String) {
        displayedText = ""
        currentIndex = 0
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

    /// Basic typewriter with no completion callback
    func typewriter(_ text: String, speed: Double = AppAnimations.typewriterSpeed) -> some View {
        modifier(TypewriterModifier(text: text, speed: speed))
    }

    /// Typewriter with completion callback — use this in GameView
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

// MARK: - Text Effect Preview
struct TextEffectPreview: View {
    @State private var resetTrigger = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                // Header
                VStack(spacing: 8) {
                    Text("Text Effects Demo")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Chronicle, Typewriter & Highlight Animations")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 20)
                
                // Reset Button
                Button(action: {
                    resetTrigger.toggle()
                }) {
                    HStack {
                        Image(systemName: "arrow.clockwise")
                        Text("Reset All Animations")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                
                Divider()
                
                // Chronicle Fade
                VStack(alignment: .leading, spacing: 16) {
                    Text("Chronicle Fade")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    
                    Text("Elegant fade-in for story text and narratives")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    if resetTrigger {
                        chronicleFadeView
                    } else {
                        chronicleFadeView
                    }
                }
                
                Divider()
                
                // Typewriter Effect
                VStack(alignment: .leading, spacing: 16) {
                    Text("Typewriter Effect")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    
                    Text("Character-by-character animation")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    if resetTrigger {
                        typewriterView
                    } else {
                        typewriterView
                    }
                }
                
                Divider()
                
                // Text Highlight
                VStack(alignment: .leading, spacing: 16) {
                    Text("Text Highlight")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    
                    Text("Emphasize important information")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    if resetTrigger {
                        textHighlightView
                    } else {
                        textHighlightView
                    }
                }
                
                // Combined Story Example
                VStack(alignment: .leading, spacing: 16) {
                    Text("Story Scene Example")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    
                    Text("All effects working together")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    if resetTrigger {
                        storySceneView
                    } else {
                        storySceneView
                    }
                }
                
                Spacer(minLength: 40)
            }
        }
        .background(Color(.systemGroupedBackground))
    }
    
    // MARK: - Components
    
    private var chronicleFadeView: some View {
        VStack(spacing: 20) {
            // Story Card 1
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "book.fill")
                        .foregroundColor(.brown)
                    Text("Chapter 1")
                        .font(.headline)
                        .foregroundColor(.brown)
                }
                
                Text("The Beginning")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("In a world ravaged by disaster, survival depends on the choices you make. Each decision carries weight, and the consequences ripple through time.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .lineSpacing(4)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.1), radius: 5)
            .chronicleFade()
            
            // Story Card 2
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "flame.fill")
                        .foregroundColor(.orange)
                    Text("Critical Moment")
                        .font(.headline)
                        .foregroundColor(.orange)
                }
                
                Text("The turning point arrives. Resources are scarce, and difficult choices must be made. The fate of many rests on your shoulders.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .lineSpacing(4)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.1), radius: 5)
            .chronicleFade()
            
            // Story Card 3
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("Hope")
                        .font(.headline)
                        .foregroundColor(.yellow)
                }
                
                Text("Even in the darkest times, there is always hope. The human spirit endures, and communities come together to rebuild what was lost.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .lineSpacing(4)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.1), radius: 5)
            .chronicleFade()
        }
        .padding(.horizontal)
    }
    
    private var typewriterView: some View {
        VStack(spacing: 20) {
            // Fast Typewriter
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "speedometer")
                        .foregroundColor(.green)
                    Text("Fast Speed (0.03s)")
                        .font(.headline)
                        .foregroundColor(.green)
                }
                
                Text("")
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(12)
                    .typewriter("This text appears quickly, character by character!", speed: 0.03)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.1), radius: 5)
            
            // Medium Typewriter
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "hare")
                        .foregroundColor(.blue)
                    Text("Medium Speed (0.05s)")
                        .font(.headline)
                        .foregroundColor(.blue)
                }
                
                Text("")
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(12)
                    .typewriter("A moderate pace creates dramatic tension...", speed: 0.05)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.1), radius: 5)
            
            // Slow Typewriter
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "tortoise")
                        .foregroundColor(.orange)
                    Text("Slow Speed (0.08s)")
                        .font(.headline)
                        .foregroundColor(.orange)
                }
                
                Text("")
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(12)
                    .typewriter("Very slow for maximum impact.", speed: 0.08)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.1), radius: 5)
        }
        .padding(.horizontal)
    }
    
    private var textHighlightView: some View {
        VStack(spacing: 20) {
            // Important Notice
            VStack(alignment: .leading, spacing: 12) {
                Text("Important Information")
                    .font(.headline)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Regular text without highlight")
                        .font(.body)
                    
                    Text("This text will be highlighted!")
                        .font(.body)
                        .fontWeight(.semibold)
                        .textHighlight()
                    
                    Text("More regular text continues here")
                        .font(.body)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.1), radius: 5)
            
            // Warning Message
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.orange)
                    Text("Warning")
                        .font(.headline)
                        .foregroundColor(.orange)
                }
                
                Text("Critical decision ahead:")
                    .font(.body)
                
                Text("This action cannot be undone")
                    .font(.body)
                    .fontWeight(.bold)
                    .textHighlight()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.1), radius: 5)
            
            // Achievement
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("Achievement Unlocked!")
                        .font(.headline)
                }
                
                Text("You earned:")
                    .font(.body)
                
                Text("+500 Experience Points")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                    .textHighlight()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.1), radius: 5)
        }
        .padding(.horizontal)
    }
    
    private var storySceneView: some View {
        VStack(spacing: 0) {
            // Scene Header
            VStack(spacing: 8) {
                Text("🌅 Day 3: The Decision")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Morning - Supply Camp")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                LinearGradient(
                    colors: [Color.orange.opacity(0.3), Color.yellow.opacity(0.2)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .chronicleFade()
            
            // Story Content
            VStack(alignment: .leading, spacing: 16) {
                // Narrative
                VStack(alignment: .leading, spacing: 12) {
                    Text("Narrative")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .textCase(.uppercase)
                    
                    Text("")
                        .font(.body)
                        .lineSpacing(4)
                        .typewriter(
                            "The supply camp is running low on resources. You must decide how to allocate the remaining supplies among the survivors.",
                            speed: 0.04
                        )
                }
                .chronicleFade()
                
                Divider()
                
                // Key Information
                VStack(alignment: .leading, spacing: 8) {
                    Text("Critical Information")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .textCase(.uppercase)
                    
                    HStack {
                        Text("Supplies Remaining:")
                        Spacer()
                        Text("35%")
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                            .textHighlight()
                    }
                    
                    HStack {
                        Text("People Dependent:")
                        Spacer()
                        Text("47 survivors")
                            .fontWeight(.bold)
                            .textHighlight()
                    }
                    
                    HStack {
                        Text("Time Until Resupply:")
                        Spacer()
                        Text("5 days")
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                            .textHighlight()
                    }
                }
                .font(.subheadline)
                .chronicleFade()
                
                Divider()
                
                // Dialogue
                VStack(alignment: .leading, spacing: 12) {
                    Text("Dialogue")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .textCase(.uppercase)
                    
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "person.circle.fill")
                            .font(.title2)
                            .foregroundColor(.blue)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Elder Sarah")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                            
                            Text("")
                                .font(.body)
                                .typewriter("\"We trust your judgment. Whatever you decide, we'll support it.\"", speed: 0.05)
                        }
                    }
                }
                .chronicleFade()
            }
            .padding()
            
            // Action Buttons
            VStack(spacing: 12) {
                Button(action: {}) {
                    Text("Equal Distribution")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                Button(action: {}) {
                    Text("Prioritize Vulnerable")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                
                Button(action: {}) {
                    Text("Ration Strictly")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                }
            }
            .padding()
            .chronicleFade()
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.15), radius: 10)
        .padding(.horizontal)
    }
}

// MARK: - Preview
#Preview {
    TextEffectPreview()
}
