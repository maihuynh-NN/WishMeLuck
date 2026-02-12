//
//  Patterns.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 12/2/26.
//

import SwiftUI

// MARK: - Pattern 1: Water Ripple (Flood)
struct WaterRipplePattern: View {
    var body: some View {
        ZStack {
            ForEach(0..<4) { i in
                Circle()
                    .stroke(Color.blue.opacity(0.3 - Double(i) * 0.07), lineWidth: 2)
                    .frame(width: CGFloat(40 + i * 25), height: CGFloat(40 + i * 25))
            }
        }
    }
}

// MARK: - Pattern 3: Bamboo Stems (Resilience)
struct BambooPattern: View {
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<7) { i in
                VStack(spacing: 3) {
                    ForEach(0..<3) { segment in
                        Rectangle()
                            .fill(Color.green.opacity(0.7))
                            .frame(width: 4, height: CGFloat(8 + i % 3 * 2))
                        
                        Circle()
                            .fill(Color.green.opacity(0.5))
                            .frame(width: 6, height: 3)
                    }
                }
            }
        }
    }
}

// MARK: - Pattern 4: Lotus Dots (Calm/Reflection)
struct LotusDotsPattern: View {
    var body: some View {
        VStack(spacing: 6) {
            // Top petal
            HStack(spacing: 8) {
                ForEach(0..<3) { _ in
                    Circle()
                        .fill(Color.pink.opacity(0.6))
                        .frame(width: 8, height: 8)
                }
            }
            
            // Middle row
            HStack(spacing: 8) {
                ForEach(0..<5) { _ in
                    Circle()
                        .fill(Color.pink.opacity(0.6))
                        .frame(width: 8, height: 8)
                }
            }
            
            // Bottom petal
            HStack(spacing: 8) {
                ForEach(0..<3) { _ in
                    Circle()
                        .fill(Color.pink.opacity(0.6))
                        .frame(width: 8, height: 8)
                }
            }
        }
    }
}


// MARK: - Preview
struct VietnamesePatternsPreview: View {
    var body: some View {
        ScrollView {
            
            VStack(spacing: 40) {
                // Header
                VStack(spacing: 8) {
                    Text("Vietnamese Patterns")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Cultural patterns for disaster response game")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 20)
                
                Divider()
                
                // Pattern 1: Water Ripple
                patternSection(
                    title: "1. Water Ripple",
                    subtitle: "For flood scenarios - represents spreading water",
                    color: .blue
                ) {
                    WaterRipplePattern()
                        .frame(height: 100)
                }
                
                Divider()

                
                // Pattern 3: Bamboo
                patternSection(
                    title: "3. Bamboo Stems",
                    subtitle: "Represents resilience and flexibility",
                    color: .green
                ) {
                    BambooPattern()
                        .frame(height: 60)
                }
                
                Divider()
                
                // Pattern 4: Lotus Dots
                patternSection(
                    title: "4. Lotus Dots",
                    subtitle: "For reflection/diary screens - represents calm",
                    color: .pink
                ) {
                    LotusDotsPattern()
                        .frame(height: 60)
                }
                
                Spacer(minLength: 40)
            }
        }
        .background(Color(.systemGroupedBackground))
    }
    
    // Helper view
    @ViewBuilder
    private func patternSection<Content: View>(
        title: String,
        subtitle: String,
        color: Color,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
            
            content()
                .frame(maxWidth: .infinity)
                .padding()
                .background(color.opacity(0.05))
                .cornerRadius(12)
                .padding(.horizontal)
        }
    }
}

#Preview {
    VietnamesePatternsPreview()
}
