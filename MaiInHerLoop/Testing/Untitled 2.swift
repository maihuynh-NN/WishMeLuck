//
//  Untitled 2.swift
//  MaiInHerLoop
//
//  Created by Huynh Ngoc Nhat Mai on 14/2/26.
//

//
//  StampCard.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 14/2/26.
//

import SwiftUI

// MARK: - Stamp Shape (Scalloped Edges)
struct StampShape: Shape {
    let scallops: Int // Number of scallops per side
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let scallop = rect.width / CGFloat(scallops)
        
        // Top edge (scalloped)
        path.move(to: CGPoint(x: 0, y: scallop/2))
        for i in 0..<scallops {
            let x = CGFloat(i) * scallop
            path.addArc(
                center: CGPoint(x: x + scallop/2, y: 0),
                radius: scallop/2,
                startAngle: .degrees(180),
                endAngle: .degrees(0),
                clockwise: false
            )
        }
        
        // Right edge (scalloped)
        let verticalScallops = Int(rect.height / scallop)
        for i in 0..<verticalScallops {
            let y = CGFloat(i) * scallop
            path.addArc(
                center: CGPoint(x: rect.width, y: y + scallop/2),
                radius: scallop/2,
                startAngle: .degrees(270),
                endAngle: .degrees(90),
                clockwise: false
            )
        }
        
        // Bottom edge (scalloped)
        for i in (0..<scallops).reversed() {
            let x = CGFloat(i) * scallop
            path.addArc(
                center: CGPoint(x: x + scallop/2, y: rect.height),
                radius: scallop/2,
                startAngle: .degrees(0),
                endAngle: .degrees(180),
                clockwise: false
            )
        }
        
        // Left edge (scalloped)
        for i in (0..<verticalScallops).reversed() {
            let y = CGFloat(i) * scallop
            path.addArc(
                center: CGPoint(x: 0, y: y + scallop/2),
                radius: scallop/2,
                startAngle: .degrees(90),
                endAngle: .degrees(270),
                clockwise: false
            )
        }
        
        path.closeSubpath()
        return path
    }
}

// MARK: - Stamp Card Component
struct StampCard<Content: View>: View {
    let backgroundColor: Color
    let borderColor: Color
    let content: Content
    
    init(
        backgroundColor: Color = .white,
        borderColor: Color = Color(red: 0.8, green: 0.7, blue: 0.4), // Gold
        @ViewBuilder content: () -> Content
    ) {
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.content = content()
    }
    
    var body: some View {
        content
            .padding(20)
            .background(backgroundColor)
            .clipShape(StampShape(scallops: 12))
            .overlay(
                StampShape(scallops: 12)
                    .stroke(borderColor, lineWidth: 3)
            )
            .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
    }
}

// MARK: - Demo Preview (Like the Vietnamese Stamps)
struct StampCardDemo: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Header
                Text("Vietnamese Stamp Cards")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                // Demo 1: North Region Card
                StampCard(
                    backgroundColor: Color(red: 0.95, green: 0.93, blue: 0.88),
                    borderColor: Color(red: 0.6, green: 0.5, blue: 0.3)
                ) {
                    VStack(spacing: 12) {
                        // Header bar
                        HStack {
                            Text("VIỆT-NAM")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(Color(red: 0.6, green: 0.5, blue: 0.3))
                            
                            Spacer()
                            
                            VStack(spacing: 2) {
                                Text("2026")
                                    .font(.system(size: 10))
                                Text("北")
                                    .font(.system(size: 12, weight: .bold))
                            }
                            .foregroundColor(Color(red: 0.6, green: 0.5, blue: 0.3))
                        }
                        
                        Rectangle()
                            .fill(Color(red: 0.6, green: 0.5, blue: 0.3))
                            .frame(height: 2)
                        
                        // Main content area
                        ZStack {
                            // Background pattern
                            Circle()
                                .fill(Color.green.opacity(0.2))
                                .frame(width: 120, height: 120)
                            
                            // Icon
                            Image(systemName: "mountain.2.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.green.opacity(0.7))
                        }
                        .frame(height: 140)
                        
                        // Side labels
                        HStack {
                            VStack(spacing: 2) {
                                ForEach(["M", "I", "Ề", "N"], id: \.self) { char in
                                    Text(char)
                                        .font(.system(size: 10, weight: .semibold))
                                }
                            }
                            .foregroundColor(Color(red: 0.6, green: 0.5, blue: 0.3))
                            
                            Spacer()
                            
                            VStack(spacing: 2) {
                                ForEach(["B", "Ắ", "C"], id: \.self) { char in
                                    Text(char)
                                        .font(.system(size: 10, weight: .semibold))
                                }
                            }
                            .foregroundColor(Color(red: 0.6, green: 0.5, blue: 0.3))
                        }
                        .offset(y: -100)
                        
                        Rectangle()
                            .fill(Color(red: 0.6, green: 0.5, blue: 0.3))
                            .frame(height: 2)
                            .offset(y: -20)
                        
                        // Footer
                        Text("NORTH")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color(red: 0.6, green: 0.5, blue: 0.3))
                            .offset(y: -20)
                    }
                    .frame(width: 200)
                }
                .frame(width: 240, height: 320)
                
                // Demo 2: Scenario Card
                StampCard(
                    backgroundColor: .white,
                    borderColor: Color.orange
                ) {
                    VStack(spacing: 16) {
                        Text("FLASH FLOOD")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                        
                        WaterRipplePattern()
                            .frame(height: 80)
                        
                        Text("Water is rising rapidly.\nMake your choice.")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                        
                        HStack(spacing: 8) {
                            ForEach(0..<3) { _ in
                                Circle()
                                    .fill(Color.orange.opacity(0.6))
                                    .frame(width: 6, height: 6)
                            }
                        }
                    }
                    .frame(width: 200)
                }
                .frame(width: 240, height: 280)
                
                // Demo 3: Diary Entry Card
                StampCard(
                    backgroundColor: Color(red: 0.98, green: 0.96, blue: 0.92),
                    borderColor: Color.pink.opacity(0.8)
                ) {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Day 1")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Spacer()
                            Text("北")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.pink)
                        }
                        
                        LotusDotsPattern()
                            .frame(height: 40)
                            .frame(maxWidth: .infinity)
                        
                        Text("Flash Flood in Hanoi")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        Text("Người Đồng Đội")
                            .font(.subheadline)
                            .foregroundColor(.pink)
                            .italic()
                        
                        Divider()
                        
                        Text("You moved toward people when crisis struck.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .lineLimit(2)
                    }
                    .frame(width: 180)
                }
                .frame(width: 220, height: 260)
                
                Spacer(minLength: 40)
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    StampCardDemo()
}
