//
//  OverlayModal.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 12/2/26.
//
import SwiftUI

struct OverlayAppearModifier: ViewModifier {
    @State private var opacity: Double = 0
    @State private var yOffset: CGFloat = -50
    
    func body(content: Content) -> some View {
        content
            .opacity(opacity)
            .offset(y: yOffset)
            .onAppear {
                withAnimation(AppAnimations.modalSlide) {
                    opacity = 1.0
                    yOffset = 0
                }
            }
    }
}

struct ModalSlideInModifier: ViewModifier {
    @State private var offset: CGFloat = 300
    
    func body(content: Content) -> some View {
        content
            .offset(y: offset)
            .onAppear {
                withAnimation(AppAnimations.modalSlide) {
                    offset = 0
                }
            }
    }
}

struct PanelExpandModifier: ViewModifier {
    @State private var scale: CGFloat = 0.8
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
            .onAppear {
                withAnimation(AppAnimations.panelExpand) {
                    scale = 1.0
                }
            }
    }
}

struct OverlayDismissModifier: ViewModifier {
    @State private var opacity: Double = 1.0
    
    func body(content: Content) -> some View {
        content
            .opacity(opacity)
            .onDisappear {
                withAnimation(AppAnimations.overlayFade) {
                    opacity = 0
                }
            }
    }
}

extension View {

    func overlayAppear() -> some View {
        modifier(OverlayAppearModifier())
    }
    
    func overlayDismiss() -> some View {
        modifier(OverlayDismissModifier())
    }
    
    func modalSlideIn() -> some View {
        modifier(ModalSlideInModifier())
    }
    
    func panelExpand() -> some View {
        modifier(PanelExpandModifier())
    }
}

import SwiftUI

// MARK: - Overlay Modal Preview
struct OverlayModalPreview: View {
    @State private var resetTrigger = false
    @State private var showModal1 = false
    @State private var showModal2 = false
    @State private var showModal3 = false
    @State private var showModal4 = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 40) {
                    // Header
                    VStack(spacing: 8) {
                        Text("Overlay & Modal Demo")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("Different modal entrance animations")
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
                    
                    // Overlay Appear
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Overlay Appear")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                        
                        Text("Fade in from top with slide")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                        
                        Button(action: {
                            showModal1 = true
                        }) {
                            HStack {
                                Image(systemName: "square.stack.3d.up")
                                Text("Show Overlay")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .cornerRadius(12)
                        }
                        .padding(.horizontal)
                    }
                    
                    Divider()
                    
                    // Modal Slide In
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Modal Slide In")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                        
                        Text("Slides up from bottom")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                        
                        Button(action: {
                            showModal2 = true
                        }) {
                            HStack {
                                Image(systemName: "arrow.up.square")
                                Text("Show Modal")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(12)
                        }
                        .padding(.horizontal)
                    }
                    
                    Divider()
                    
                    // Panel Expand
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Panel Expand")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                        
                        Text("Scale up animation")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                        
                        Button(action: {
                            showModal3 = true
                        }) {
                            HStack {
                                Image(systemName: "arrow.up.left.and.arrow.down.right")
                                Text("Show Panel")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .cornerRadius(12)
                        }
                        .padding(.horizontal)
                    }
                    
                    Divider()
                    
                    // All Combined
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Combined Example")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                        
                        Text("Multiple overlays with different animations")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                        
                        Button(action: {
                            showModal4 = true
                        }) {
                            HStack {
                                Image(systemName: "sparkles")
                                Text("Show All Effects")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(
                                    colors: [.blue, .purple],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(12)
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 40)
                }
            }
            .background(Color(.systemGroupedBackground))
            
            // Modal 1: Overlay Appear
            if showModal1 {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showModal1 = false
                    }
                
                VStack(spacing: 20) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Notification")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("This overlay appears from top")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            showModal1 = false
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title2)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Text("The overlay smoothly slides down and fades in, perfect for notifications and alerts.")
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    Button(action: {
                        showModal1 = false
                    }) {
                        Text("Got it")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .cornerRadius(10)
                    }
                }
                .padding(24)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.3), radius: 20)
                .padding(.horizontal, 30)
                .overlayAppear()
            }
            
            // Modal 2: Modal Slide In
            if showModal2 {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showModal2 = false
                    }
                
                VStack {
                    Spacer()
                    
                    VStack(spacing: 24) {
                        // Handle
                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 40, height: 5)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Bottom Sheet")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Text("This modal slides up from the bottom, commonly used for actions sheets and selections.")
                                .font(.body)
                                .foregroundColor(.secondary)
                            
                            Divider()
                            
                            VStack(spacing: 12) {
                                ForEach(["Option 1", "Option 2", "Option 3"], id: \.self) { option in
                                    Button(action: {
                                        showModal2 = false
                                    }) {
                                        HStack {
                                            Image(systemName: "checkmark.circle")
                                            Text(option)
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.gray)
                                        }
                                        .padding()
                                        .background(Color.gray.opacity(0.1))
                                        .cornerRadius(10)
                                    }
                                    .foregroundColor(.primary)
                                }
                            }
                        }
                        
                        Button(action: {
                            showModal2 = false
                        }) {
                            Text("Cancel")
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(12)
                        }
                    }
                    .padding(24)
                    .background(Color.white)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                    .modalSlideIn()
                }
                .ignoresSafeArea()
            }
            
            // Modal 3: Panel Expand
            if showModal3 {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showModal3 = false
                    }
                
                VStack(spacing: 20) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.orange)
                    
                    Text("Panel Animation")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("This panel expands from center, great for alerts, confirmations, and focus content.")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                    
                    HStack(spacing: 12) {
                        Button(action: {
                            showModal3 = false
                        }) {
                            Text("Cancel")
                                .fontWeight(.medium)
                                .foregroundColor(.primary)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            showModal3 = false
                        }) {
                            Text("Confirm")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.orange)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(30)
                .background(Color.white)
                .cornerRadius(24)
                .shadow(color: .black.opacity(0.3), radius: 20)
                .padding(.horizontal, 40)
                .panelExpand()
            }
            
            // Modal 4: Combined Effects
            if showModal4 {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showModal4 = false
                    }
                
                VStack {
                    // Top notification
                    VStack(spacing: 12) {
                        HStack {
                            Image(systemName: "bell.fill")
                                .foregroundColor(.blue)
                            Text("Top Notification")
                                .fontWeight(.semibold)
                            Spacer()
                            Button(action: {}) {
                                Image(systemName: "xmark")
                                    .foregroundColor(.gray)
                            }
                        }
                        Text("Using overlayAppear modifier")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 5)
                    .padding(.horizontal)
                    .padding(.top, 60)
                    .overlayAppear()
                    
                    Spacer()
                    
                    // Center dialog
                    VStack(spacing: 16) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.green)
                        
                        Text("Success!")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Using panelExpand modifier")
                            .font(.body)
                            .foregroundColor(.secondary)
                        
                        Button(action: {
                            showModal4 = false
                        }) {
                            Text("Continue")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                    }
                    .padding(24)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .padding(.horizontal, 40)
                    .panelExpand()
                    
                    Spacer()
                    
                    // Bottom sheet info
                    VStack(spacing: 12) {
                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 40, height: 5)
                        
                        Text("Bottom Info")
                            .font(.headline)
                        
                        Text("Using modalSlideIn modifier")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Button(action: {
                            showModal4 = false
                        }) {
                            Text("Close All")
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                    .padding(24)
                    .background(Color.white)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                    .modalSlideIn()
                }
                .ignoresSafeArea()
            }
        }
    }
}

// MARK: - Helper Extension
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// MARK: - Preview
#Preview {
    OverlayModalPreview()
}

