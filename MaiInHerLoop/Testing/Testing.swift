import SwiftUI

// MARK: - 1. REFINED: Đông Sơn Bronze Drum (Better Spiral Logic)
struct DongSonBronzeDrumBackground: View {
    var body: some View {
        ZStack {
            Color(hex: "#F5F1E8") // Your parchment color
            
            Canvas { context, size in
                let center = CGPoint(x: size.width / 2, y: size.height / 2)
                let maxRadius = min(size.width, size.height) / 1.8
                
                // Concentric circles (bronze drum rings)
                for i in stride(from: 30, to: maxRadius, by: 35) {
                    let circle = Path(ellipseIn: CGRect(
                        x: center.x - i,
                        y: center.y - i,
                        width: i * 2,
                        height: i * 2
                    ))
                    
                    context.stroke(circle,
                                   with: .color(Color(hex: "#C9A877").opacity(0.12)), // Aged gold
                                   lineWidth: 1.5)
                }
                
                // Add radiating lines (like bronze drum rays)
                for i in 0..<12 {
                    let angle = Double(i) / 12 * .pi * 2
                    let startRadius: CGFloat = 80
                    let endRadius = maxRadius
                    
                    let start = CGPoint(
                        x: center.x + cos(angle) * startRadius,
                        y: center.y + sin(angle) * startRadius
                    )
                    let end = CGPoint(
                        x: center.x + cos(angle) * endRadius,
                        y: center.y + sin(angle) * endRadius
                    )
                    
                    var path = Path()
                    path.move(to: start)
                    path.addLine(to: end)
                    
                    context.stroke(path,
                                   with: .color(Color(hex: "#8B6F47").opacity(0.08)),
                                   lineWidth: 1.0)
                }
                
                // Small decorative spirals at cardinal points (authentic detail)
                let cardinalAngles: [Double] = [0, .pi/2, .pi, .pi * 1.5]
                for angle in cardinalAngles {
                    let spiralCenter = CGPoint(
                        x: center.x + cos(angle) * (maxRadius * 0.7),
                        y: center.y + sin(angle) * (maxRadius * 0.7)
                    )
                    
                    drawTinySpiral(context: context, center: spiralCenter)
                }
            }
        }
        .ignoresSafeArea()
    }
    
    private func drawTinySpiral(context: GraphicsContext, center: CGPoint) {
        var path = Path()
        for i in 0...20 {
            let angle = CGFloat(i) * 0.3
            let radius = CGFloat(i) * 0.6
            let x = center.x + cos(angle) * radius
            let y = center.y + sin(angle) * radius
            
            if i == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        context.stroke(path,
                       with: .color(Color(hex: "#C9A877").opacity(0.15)),
                       lineWidth: 1.0)
    }
}

// MARK: - 2. REFINED: Silk Weave + Vietnamese Textile Pattern
struct SilkTextileBackground: View {
    var body: some View {
        ZStack {
            Color(hex: "#F5F1E8")
            
            Canvas { context, size in
                let spacing: CGFloat = 12
                
                // Vertical threads
                for x in stride(from: 0, through: size.width, by: spacing) {
                    var path = Path()
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: x, y: size.height))
                    context.stroke(path,
                                   with: .color(Color(hex: "#8B6F47").opacity(0.04)),
                                   lineWidth: 0.8)
                }
                
                // Horizontal threads
                for y in stride(from: 0, through: size.height, by: spacing) {
                    var path = Path()
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: size.width, y: y))
                    context.stroke(path,
                                   with: .color(Color(hex: "#8B6F47").opacity(0.04)),
                                   lineWidth: 0.8)
                }
                
                // Add diagonal accent threads (like áo dài silk detail)
                for i in stride(from: 0, through: size.width + size.height, by: spacing * 4) {
                    var path = Path()
                    path.move(to: CGPoint(x: i, y: 0))
                    path.addLine(to: CGPoint(x: i - size.height, y: size.height))
                    
                    context.stroke(path,
                                   with: .color(Color(hex: "#C9A877").opacity(0.06)),
                                   lineWidth: 0.5)
                }
            }
        }
        .ignoresSafeArea()
    }
}

// MARK: - 3. REFINED: Monsoon Rain + Rice Field Reflections
struct MonsoonRiceFieldBackground: View {
    @State private var move = false
    
    var body: some View {
        ZStack {
            // Base: wet rice field color
            Color(hex: "#1B4332").opacity(0.08)
            // Large water ripples (rice paddy flooding)
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color(hex: "#2D5016").opacity(0.3),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: 0,
                        endRadius: 200
                    )
                )
                .frame(width: 400)
                .offset(x: move ? 60 : -60, y: move ? -40 : 40)
                .blur(radius: 40)
            
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color(hex: "#3A5A40").opacity(0.25),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: 0,
                        endRadius: 180
                    )
                )
                .frame(width: 350)
                .offset(x: move ? -50 : 50, y: move ? 50 : -50)
                .blur(radius: 50)
            
            // Rain streaks (subtle)
            Canvas { context, size in
                for i in 0..<30 {
                    let x = CGFloat.random(in: 0...size.width)
                    let y = CGFloat.random(in: 0...size.height)
                    
                    var path = Path()
                    path.move(to: CGPoint(x: x, y: y))
                    path.addLine(to: CGPoint(x: x + 2, y: y + 40))
                    
                    context.stroke(path,
                                   with: .color(Color(hex: "#F5F1E8").opacity(0.08)),
                                   lineWidth: 0.5)
                }
            }
        }
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.easeInOut(duration: 10).repeatForever(autoreverses: true)) {
                move.toggle()
            }
        }
    }
}

// MARK: - 4. REFINED: Northern Mist + Limestone Mountains
struct NorthernLimestoneMistBackground: View {
    var body: some View {
        ZStack {
            // Base gradient (foggy morning in Ha Long Bay)
            LinearGradient(
                colors: [
                    Color(hex: "#E6DED3"), // Light fog
                    Color(hex: "#C9BDA8"), // Dense fog
                    Color(hex: "#D4C5B0")  // Mountain base
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            
            // Mountain silhouette suggestion (very faint)
            Canvas { context, size in
                var path = Path()
                
                // Gentle mountain curve
                path.move(to: CGPoint(x: 0, y: size.height * 0.6))
                path.addQuadCurve(
                    to: CGPoint(x: size.width * 0.3, y: size.height * 0.5),
                    control: CGPoint(x: size.width * 0.15, y: size.height * 0.4)
                )
                path.addQuadCurve(
                    to: CGPoint(x: size.width * 0.7, y: size.height * 0.55),
                    control: CGPoint(x: size.width * 0.5, y: size.height * 0.45)
                )
                path.addQuadCurve(
                    to: CGPoint(x: size.width, y: size.height * 0.6),
                    control: CGPoint(x: size.width * 0.85, y: size.height * 0.5)
                )
                path.addLine(to: CGPoint(x: size.width, y: size.height))
                path.addLine(to: CGPoint(x: 0, y: size.height))
                path.closeSubpath()
                
                context.fill(path, with: .color(Color(hex: "#8B6F47").opacity(0.1)))
            }
            
            // Fog layers
            Circle()
                .fill(Color.white.opacity(0.15))
                .frame(width: 500)
                .blur(radius: 100)
                .offset(y: -150)
            
            Circle()
                .fill(Color(hex: "#F5F1E8").opacity(0.12))
                .frame(width: 450)
                .blur(radius: 90)
                .offset(x: -80, y: 50)
        }
        .ignoresSafeArea()
    }
}

// MARK: - 5. REFINED: Cracked Earth + Drought Pattern
struct DroughtCrackedEarthBackground: View {
    var body: some View {
        ZStack {
            Color(hex: "#E6DED3") // Dry earth base
            
            Canvas { context, size in
                // Organic crack patterns (not random squares)
                let crackPoints: [(CGPoint, CGPoint)] = [
                    // Vertical main crack
                    (CGPoint(x: size.width * 0.3, y: 0),
                     CGPoint(x: size.width * 0.35, y: size.height)),
                    
                    (CGPoint(x: size.width * 0.65, y: 0),
                     CGPoint(x: size.width * 0.6, y: size.height)),
                    
                    // Horizontal cracks
                    (CGPoint(x: 0, y: size.height * 0.25),
                     CGPoint(x: size.width, y: size.height * 0.27)),
                    
                    (CGPoint(x: 0, y: size.height * 0.6),
                     CGPoint(x: size.width, y: size.height * 0.58)),
                    
                    // Diagonal branch cracks
                    (CGPoint(x: size.width * 0.1, y: size.height * 0.3),
                     CGPoint(x: size.width * 0.4, y: size.height * 0.5)),
                    
                    (CGPoint(x: size.width * 0.7, y: size.height * 0.4),
                     CGPoint(x: size.width * 0.9, y: size.height * 0.7))
                ]
                
                for (start, end) in crackPoints {
                    var path = Path()
                    path.move(to: start)
                    
                    // Add slight randomness to crack
                    let midX = (start.x + end.x) / 2 + CGFloat.random(in: -20...20)
                    let midY = (start.y + end.y) / 2 + CGFloat.random(in: -20...20)
                    let mid = CGPoint(x: midX, y: midY)
                    
                    path.addQuadCurve(to: mid, control: CGPoint(
                        x: (start.x + midX) / 2,
                        y: (start.y + midY) / 2
                    ))
                    path.addQuadCurve(to: end, control: CGPoint(
                        x: (midX + end.x) / 2,
                        y: (midY + end.y) / 2
                    ))
                    
                    // Double line for crack depth
                    context.stroke(path,
                                   with: .color(Color(hex: "#8B6F47").opacity(0.15)),
                                   lineWidth: 2.5)
                    
                    context.stroke(path,
                                   with: .color(Color(hex: "#A0614F").opacity(0.08)),
                                   lineWidth: 1.2)
                }
            }
        }
        .ignoresSafeArea()
    }
}

// MARK: - 6. NEW: Conical Hat Weave Pattern
struct ConicalHatWeaveBackground: View {
    var body: some View {
        ZStack {
            Color(hex: "#F5F1E8")
            
            Canvas { context, size in
                let spacing: CGFloat = 8
                let angle: CGFloat = 15 * .pi / 180 // Diagonal weave
                
                // Diagonal lines (like nón lá palm leaf weave)
                for i in stride(from: -size.height, through: size.width + size.height, by: spacing) {
                    var path = Path()
                    let startX = i
                    let startY: CGFloat = 0
                    let endX = i - size.height * tan(angle)
                    let endY = size.height
                    
                    path.move(to: CGPoint(x: startX, y: startY))
                    path.addLine(to: CGPoint(x: endX, y: endY))
                    
                    context.stroke(path,
                                   with: .color(Color(hex: "#C9A877").opacity(0.06)),
                                   lineWidth: 1.0)
                }
                
                // Cross-weave (opposite angle)
                for i in stride(from: 0, through: size.width + size.height, by: spacing) {
                    var path = Path()
                    let startX = i
                    let startY: CGFloat = 0
                    let endX = i + size.height * tan(angle)
                    let endY = size.height
                    
                    path.move(to: CGPoint(x: startX, y: startY))
                    path.addLine(to: CGPoint(x: endX, y: endY))
                    
                    context.stroke(path,
                                   with: .color(Color(hex: "#C9A877").opacity(0.06)),
                                   lineWidth: 1.0)
                }
            }
        }
        .ignoresSafeArea()
    }
}

// MARK: - Preview Selector
struct VietnameseBackgroundPreview: View {
    @State private var selected = 0
    
    let backgrounds = [
        "Đông Sơn Drum",
        "Silk Textile",
        "Monsoon Rice Field",
        "Northern Limestone",
        "Drought Cracks",
        "Conical Hat Weave"
    ]
    
    var body: some View {
        ZStack {
            Group {
                switch selected {
                case 0: DongSonBronzeDrumBackground()
                case 1: SilkTextileBackground()
                case 2: MonsoonRiceFieldBackground()
                case 3: NorthernLimestoneMistBackground()
                case 4: DroughtCrackedEarthBackground()
                case 5: ConicalHatWeaveBackground()
                default: Color.clear
                }
            }
            
            VStack {
                Spacer()
                
                // Sample card
                VStack(alignment: .leading, spacing: 12) {
                    Text("Lũ Quét ở Hà Nội")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(Color(hex: "#2C1810"))
                    
                    Text("Nước đang dâng cao. Bạn sẽ làm gì?")
                        .font(.system(size: 17))
                        .foregroundColor(Color(hex: "#2C1810"))
                }
                .padding(24)
                .background(Color(hex: "#F5F1E8"))
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.1), radius: 8)
                .padding(.horizontal, 32)
                
                Spacer()
                
                // Picker
                Picker("Background", selection: $selected) {
                    ForEach(0..<backgrounds.count, id: \.self) { i in
                        Text(backgrounds[i]).tag(i)
                    }
                }
                .pickerStyle(.menu)
                .padding(20)
                .background(Color(hex: "#F5F1E8").opacity(0.95))
                .cornerRadius(12)
                .padding(.horizontal, 32)
                .padding(.bottom, 32)
            }
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(.sRGB, red: Double(r)/255, green: Double(g)/255, blue: Double(b)/255, opacity: Double(a)/255)
    }
}

#Preview {
    VietnameseBackgroundPreview()
}
