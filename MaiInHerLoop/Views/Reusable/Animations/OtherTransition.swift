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

// MARK: - Other Transition Preview
struct OtherTransitionPreview: View {
    @State private var resetTrigger = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Header
                VStack{
                    Text("Game Transitions Demo")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Day, Game Start & End Animations")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                // Reset Button
                Button(action: {
                    resetTrigger.toggle()
                }) {
                    HStack {
                        Image(systemName: "arrow.clockwise")
                        Text("Reset All Transitions")
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
                
                // Day Transition
                VStack{
                    Text("Day Transition")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    
                    Text("Scale and fade transition between days")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    if resetTrigger {
                        dayTransitionView
                    } else {
                        dayTransitionView
                    }
                }
                
                Divider()
                
                // Game Start
                VStack(alignment: .leading, spacing: 16) {
                    Text("Game Start")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    
                    Text("Slide up animation when game begins")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    if resetTrigger {
                        gameStartView
                    } else {
                        gameStartView
                    }
                }
                
                Divider()
                
                // Game End
                VStack(alignment: .leading, spacing: 16) {
                    Text("Game End")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    
                    Text("Fade and blur when game ends")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    if resetTrigger {
                        gameEndView
                    } else {
                        gameEndView
                    }
                }
                
                // Full Game Flow Example
                VStack(alignment: .leading, spacing: 16) {
                    Text("Complete Game Flow")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    
                    Text("See all transitions in sequence")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    if resetTrigger {
                        gameFlowExample
                    } else {
                        gameFlowExample
                    }
                }
                
                Spacer(minLength: 40)
            }
        }
        .background(Color(.systemGroupedBackground))
    }
    
    // MARK: - Components
    
    private var dayTransitionView: some View {
        VStack(spacing: 16) {
            ForEach(1...3, id: \.self) { day in
                VStack(spacing: 12) {
                    // Day Badge
                    HStack {
                        Image(systemName: "calendar")
                            .font(.title2)
                            .foregroundColor(.white)
                        
                        Text("Day \(day)")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Image(systemName: iconForDay(day))
                            .font(.system(size: 40))
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [colorForDay(day), colorForDay(day).opacity(0.7)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(16)
                    
                    // Day Description
                    Text(descriptionForDay(day))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal)
                .dayTransition()
            }
        }
    }
    
    private var gameStartView: some View {
        VStack(spacing: 20) {
            // Game Title Card
            VStack(spacing: 16) {
                Image(systemName: "gamecontroller.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.green)
                
                Text("Survival Challenge")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Prepare to begin...")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Divider()
                    .padding(.horizontal, 40)
                
                HStack(spacing: 30) {
                    VStack {
                        Image(systemName: "heart.fill")
                            .font(.title)
                            .foregroundColor(.red)
                        Text("Health: 100")
                            .font(.caption)
                    }
                    
                    VStack {
                        Image(systemName: "star.fill")
                            .font(.title)
                            .foregroundColor(.yellow)
                        Text("Score: 0")
                            .font(.caption)
                    }
                    
                    VStack {
                        Image(systemName: "timer")
                            .font(.title)
                            .foregroundColor(.blue)
                        Text("Time: 00:00")
                            .font(.caption)
                    }
                }
            }
            .padding(30)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.15), radius: 10)
            .gameStart()
            
            // Start Button
            Button(action: {}) {
                HStack {
                    Image(systemName: "play.fill")
                    Text("Start Game")
                        .fontWeight(.semibold)
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .cornerRadius(12)
            }
            .gameStart()
        }
        .padding(.horizontal)
    }
    
    private var gameEndView: some View {
        VStack(spacing: 20) {
            // Game Over Screen
            VStack(spacing: 16) {
                Image(systemName: "flag.checkered")
                    .font(.system(size: 60))
                    .foregroundColor(.gray)
                
                Text("Game Over")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Divider()
                    .padding(.horizontal, 40)
                
                VStack(spacing: 12) {
                    HStack {
                        Text("Final Score:")
                            .font(.headline)
                        Spacer()
                        Text("8,450")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }
                    
                    HStack {
                        Text("Days Survived:")
                            .font(.headline)
                        Spacer()
                        Text("7")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                    }
                    
                    HStack {
                        Text("Challenges Completed:")
                            .font(.headline)
                        Spacer()
                        Text("12/15")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
            }
            .padding(30)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.15), radius: 10)
            .gameEnd()
            
            // Action Buttons
            HStack(spacing: 12) {
                Button(action: {}) {
                    Text("Menu")
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(12)
                }
                
                Button(action: {}) {
                    Text("Play Again")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                }
            }
            .gameEnd()
        }
        .padding(.horizontal)
    }
    
    private var gameFlowExample: some View {
        VStack(spacing: 16) {
            Text("Complete Sequence")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            VStack(spacing: 12) {
                // Step 1: Day Transition
                HStack {
                    Text("1")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .background(Circle().fill(Color.purple))
                    
                    Text("Day 1 Begins")
                        .font(.headline)
                    
                    Spacer()
                    
                    Image(systemName: "sun.max.fill")
                        .foregroundColor(.orange)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .dayTransition()
                
                // Step 2: Game Start
                HStack {
                    Text("2")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .background(Circle().fill(Color.green))
                    
                    Text("Game Interface Appears")
                        .font(.headline)
                    
                    Spacer()
                    
                    Image(systemName: "play.fill")
                        .foregroundColor(.green)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .gameStart()
                
                // Step 3: Game End
                HStack {
                    Text("3")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .background(Circle().fill(Color.red))
                    
                    Text("Day Ends")
                        .font(.headline)
                    
                    Spacer()
                    
                    Image(systemName: "moon.fill")
                        .foregroundColor(.indigo)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .gameEnd()
            }
            .padding(.horizontal)
        }
    }
    
    // MARK: - Helper Functions
    
    private func iconForDay(_ day: Int) -> String {
        switch day {
        case 1: return "sun.max.fill"
        case 2: return "cloud.sun.fill"
        case 3: return "moon.stars.fill"
        default: return "calendar"
        }
    }
    
    private func colorForDay(_ day: Int) -> Color {
        switch day {
        case 1: return .orange
        case 2: return .blue
        case 3: return .purple
        default: return .gray
        }
    }
    
    private func descriptionForDay(_ day: Int) -> String {
        switch day {
        case 1: return "Morning: A new day begins with fresh challenges"
        case 2: return "Afternoon: The situation intensifies"
        case 3: return "Evening: Final decisions must be made"
        default: return ""
        }
    }
}

// MARK: - Preview
#Preview {
    OtherTransitionPreview()
}
