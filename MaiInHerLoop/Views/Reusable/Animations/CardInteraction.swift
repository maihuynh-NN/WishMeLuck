import SwiftUI

// MARK: - Staggered Appear
struct StaggeredAppearModifier: ViewModifier {
    let delay: Double
    @State private var opacity: Double = 0
    @State private var yOffset: CGFloat = 20
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View {
        content
            .opacity(opacity)
            .offset(y: reduceMotion ? 0 : yOffset)
            .onAppear {
                if reduceMotion {
                    opacity = 1.0
                    return
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    withAnimation(.easeOut(duration: 0.6)) {
                        opacity = 1.0
                        yOffset = 0
                    }
                }
            }
    }
}

// MARK: - Card Select
struct CardSelectStyle: ButtonStyle {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed && !reduceMotion ? 0.95 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

// MARK: - Card Submit
struct CardSubmitModifier: ViewModifier {
    @State private var isSubmitted = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View {
        content
            .scaleEffect(isSubmitted && !reduceMotion ? 0.95 : 1.0)
            .background(
                Color("Beige")
                    .opacity(isSubmitted ? 1.0 : 0)
            )
            .onAppear {
                guard !reduceMotion else {
                    isSubmitted = true
                    return
                }
                withAnimation(AppAnimations.cardSubmit) {
                    isSubmitted = true
                }
            }
    }
}

// MARK: - View Extensions
extension View {
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
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("2. Card Select")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.horizontal)

                    Text("Tap to see bounce effect")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)

                    cardSelectCards
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

    private var cardSelectCards: some View {
        let options: [(icon: String, colors: (Color, Color))] = [
            ("star.fill", (Color.orange, Color.red)),
            ("heart.fill", (Color.pink, Color.purple))
        ]
        return HStack(spacing: 16) {
            ForEach(options.indices, id: \.self) { index in
                let item = options[index]
                Button(action: {}) {
                    VStack {
                        Image(systemName: item.icon)
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
                            colors: [item.colors.0, item.colors.1],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(16)
                }
                .buttonStyle(CardSelectStyle())
            }
        }
        .padding(.horizontal)
    }
}

// MARK: - Preview
#Preview {
    CustomModifiersPreview()
}
