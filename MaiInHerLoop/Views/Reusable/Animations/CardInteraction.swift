//
//  CardInteraction.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 12/2/26.
//
import SwiftUI

struct StaggeredAppearModifier: ViewModifier {
    let delay: Double
    @State private var opacity: Double = 0
    @State private var yOffset: CGFloat = 20
    
    func body(content: Content) -> some View {
        content
            .opacity(opacity)
            .offset(y: yOffset)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    withAnimation(.easeOut(duration: 0.6)) {
                        opacity = 1.0
                        yOffset = 0
                    }
                }
            }
    }
}

struct CardSelectModifier: ViewModifier {
    @State private var bounceScale: CGFloat = 1.0
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(bounceScale)
            .onTapGesture {
                withAnimation(.easeOut(duration: 0.15)) {
                    bounceScale = 0.8
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.easeOut(duration: 0.25)) {
                        bounceScale = 1.0
                    }
                }
            }
    }
}

struct CardSubmitModifier: ViewModifier {
    @State private var isSubmitted = false
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isSubmitted ? 0.95 : 1.0)
            .background(
                Color("Background")
                    .opacity(isSubmitted ? 1.0 : 0)
            )
            .onAppear {
                withAnimation(AppAnimations.cardSubmit) {
                    isSubmitted = true
                }
            }
    }
}

extension View {
    // Card/Interactive
    func cardSelect() -> some View {
        modifier(CardSelectModifier())
    }
    
    func cardSubmit() -> some View {
        modifier(CardSubmitModifier())
    }
    
    func staggeredAppear(delay: Double) -> some View {
        modifier(StaggeredAppearModifier(delay: delay))
    }
}


// MARK: - Preview for Custom Modifiers
struct CustomModifiersPreview: View {
    @State private var resetTrigger = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Header
                VStack(spacing: 8) {
                    Text("Custom Modifiers Demo")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Tap cards and buttons to see effects")
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
                    .padding(.horizontal)
                
                // 3. Card Submit Modifier
                VStack(alignment: .leading, spacing: 16) {
                    Text("3. Card Submit")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    
                    Text("Scale animation on appear")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    if resetTrigger {
                        submitCard
                    } else {
                        submitCard
                    }
                }
                
                Divider()
                    .padding(.horizontal)
                
                // 1. Staggered Appear Modifier
                VStack(alignment: .leading, spacing: 16) {
                    Text("1. Staggered Appear")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    
                    Text("Cards appear one by one with fade & slide")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    if resetTrigger {
                        staggeredCards
                    } else {
                        staggeredCards
                    }
                }
                
                Divider()
                    .padding(.horizontal)
                
                // 2. Card Select Modifier
                VStack(alignment: .leading, spacing: 16) {
                    Text("2. Card Select")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    
                    Text("Tap to see bounce effect")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    HStack(spacing: 16) {
                        ForEach(0..<2) { index in
                            VStack {
                                Image(systemName: index == 0 ? "star.fill" : "heart.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(.white)
                                Text("Option \(index + 1)")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 40)
                            .background(
                                LinearGradient(
                                    colors: [
                                        index == 0 ? Color.orange : Color.pink,
                                        index == 0 ? Color.red : Color.purple
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .cornerRadius(16)
                            .cardSelect()
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer(minLength: 40)
            }
        }
        .background(Color(.systemGroupedBackground))
    }
    
    // MARK: - Component Views
    
    private var staggeredCards: some View {
        VStack(spacing: 12) {
            ForEach(0..<4) { index in
                HStack {
                    Image(systemName: "\(index + 1).circle.fill")
                        .font(.title2)
                        .foregroundColor(.blue)
                    
                    Text("Card \(index + 1)")
                        .font(.headline)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                .staggeredAppear(delay: Double(index) * 0.15)
            }
        }
        .padding(.horizontal)
    }
    
    private var submitCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "checkmark.circle.fill")
                    .font(.title)
                    .foregroundColor(.green)
                
                VStack(alignment: .leading) {
                    Text("Submission Complete")
                        .font(.headline)
                    Text("Your answer has been recorded")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        }
        .padding(.horizontal)
        .cardSubmit()
    }
}

// MARK: - Preview
#Preview {
    CustomModifiersPreview()
}
