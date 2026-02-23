//
//  ButtonEffect.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 12/2/26.
//
import SwiftUI

struct EmergencyPulseModifier: ViewModifier {
    @State private var isPulsing = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View {
        content
            .scaleEffect(isPulsing ? 1.05 : 1.0)
            .opacity(isPulsing ? 0.7 : 1.0)
            .onAppear {
                guard !reduceMotion else { return }
                withAnimation(AppAnimations.emergencyPulse) {
                    isPulsing = true
                }
            }
    }
}

struct WarningFlashModifier: ViewModifier {
    @State private var isFlashing = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View {
        content
            .foregroundColor(isFlashing ? .orange : .yellow)
            .onAppear {
                guard !reduceMotion else { return }
                withAnimation(AppAnimations.warningFlash) {
                    isFlashing = true
                }
            }
    }
}

extension View {
    func emergencyPulse() -> some View {
        modifier(EmergencyPulseModifier())
    }

    func warningFlash() -> some View {
        modifier(WarningFlashModifier())
    }
}

// MARK: - Button Effect Preview
struct ButtonEffectPreview: View {
    @State private var resetTrigger = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                // Header
                VStack(spacing: 8) {
                    Text("Button Effects Demo")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Emergency & Warning Animations")
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
                        Text("Reset Animations")
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
                
                // Emergency Pulse Effect
                VStack(alignment: .leading, spacing: 16) {
                    Text("Emergency Pulse")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    
                    Text("Continuous pulsing animation for critical alerts")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    if resetTrigger {
                        emergencyButtons
                    } else {
                        emergencyButtons
                    }
                }
                
                Divider()
                
                // Warning Flash Effect
                VStack(alignment: .leading, spacing: 16) {
                    Text("Warning Flash")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    
                    Text("Color flashing for warning indicators")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    if resetTrigger {
                        warningIndicators
                    } else {
                        warningIndicators
                    }
                }
                
                // Combined Example
                VStack(alignment: .leading, spacing: 16) {
                    Text("Combined Effects")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    
                    Text("Real-world emergency scenario")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    if resetTrigger {
                        emergencyPanel
                    } else {
                        emergencyPanel
                    }
                }
                
                Spacer(minLength: 40)
            }
        }
        .background(Color(.systemGroupedBackground))
    }
    
    // MARK: - Components
    
    private var emergencyButtons: some View {
        VStack(spacing: 16) {
            // SOS Button
            Button(action: {}) {
                HStack {
                    Image(systemName: "sos.circle.fill")
                        .font(.title)
                    Text("EMERGENCY SOS")
                        .font(.headline)
                        .fontWeight(.bold)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(Color.red)
                .cornerRadius(16)
            }
            .emergencyPulse()
            
            // Alert Button
            Button(action: {}) {
                HStack {
                    Image(systemName: "bell.fill")
                        .font(.title2)
                    Text("Critical Alert")
                        .font(.headline)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color.orange)
                .cornerRadius(12)
            }
            .emergencyPulse()
            
            // Danger Zone
            Button(action: {}) {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.title3)
                    Text("Danger Zone")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Color.red.opacity(0.8))
                .cornerRadius(10)
            }
            .emergencyPulse()
        }
        .padding(.horizontal)
    }
    
    private var warningIndicators: some View {
        VStack(spacing: 20) {
            // Warning Badges
            HStack(spacing: 16) {
                ForEach(["Low Battery", "High Temp", "Signal Weak"], id: \.self) { warning in
                    VStack {
                        Image(systemName: iconFor(warning))
                            .font(.title)
                            .warningFlash()
                        
                        Text(warning)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 4)
                }
            }
            
            // Warning Banner
            HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.title2)
                    .warningFlash()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("System Warning")
                        .font(.headline)
                    Text("Attention required")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Button(action: {}) {
                    Text("Review")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
            }
            .padding()
            .background(Color.orange.opacity(0.1))
            .cornerRadius(12)
        }
        .padding(.horizontal)
    }
    
    private var emergencyPanel: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.title)
                    .warningFlash()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("CRITICAL WARNING")
                        .font(.headline)
                        .fontWeight(.bold)
                    Text("Immediate action required")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            .padding()
            .background(Color.orange.opacity(0.2))
            
            Divider()
            
            // Content
            VStack(alignment: .leading, spacing: 12) {
                Text("Disaster Alert")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text("A severe weather warning has been issued for your area. Take immediate shelter.")
                    .font(.body)
                    .foregroundColor(.secondary)
                
                // Action Buttons
                HStack(spacing: 12) {
                    Button(action: {}) {
                        Text("Dismiss")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                    
                    Button(action: {}) {
                        Text("Take Action")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    .emergencyPulse()
                }
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.2), radius: 10)
        .padding(.horizontal)
    }
    
    // Helper function
    private func iconFor(_ warning: String) -> String {
        switch warning {
        case "Low Battery": return "battery.25"
        case "High Temp": return "thermometer.high"
        case "Signal Weak": return "antenna.radiowaves.left.and.right.slash"
        default: return "exclamationmark.triangle"
        }
    }
}

// MARK: - Preview
#Preview {
    ButtonEffectPreview()
}
