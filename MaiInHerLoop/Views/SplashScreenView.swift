//
//  SplashScreenView.swift
//  MaiInHerLoop
//
//  Created by Huynh Ngoc Nhat Mai on 26/2/26.
//

import SwiftUI

struct SplashScreenView: View {
    
    // MARK: - Persisted State
    @AppStorage("playerName") private var playerName = ""
    
    // MARK: - Local State
    @State private var nameInput = ""
    @State private var showButton = false
    @State private var navigateToRegion = false
    
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @FocusState private var isNameFieldFocused: Bool
    
    // MARK: - Responsive (same pattern as MissionBriefingOverlay)
    private var isIPad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
    private var panelWidth: CGFloat { isIPad ? 420 : 320 }
    private var panelHeight: CGFloat { isIPad ? 420 : 360 }
    
    // MARK: - Computed
    private var canProceed: Bool {
        !nameInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            // Background — full bleed
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                panelContent
                    .chronicleFade()
                
                Spacer()
            }
        }
        .onAppear {
            nameInput = playerName
            showButton = !nameInput.isEmpty
        }
        .navigationDestination(isPresented: $navigateToRegion) {
            RegionSelectionView()
        }
    }
    
    // MARK: - Panel Content
    private var panelContent: some View {
        CustomPanel(
            backgroundColor: Color.clear,
            size: .customed(width: panelWidth, height: panelHeight)
        ) {
            ZStack {
                // Panel fill — same pattern as MissionBriefingOverlay
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color("Beige3").opacity(0.6))
                    .frame(width: panelWidth - 5, height: panelHeight - 5)
                    .accessibilityHidden(true)
                
                VStack(spacing: 16) {
                    
                    // Top ornament
                    BarRow(color: Color("Moss"), count: 7)
                        .padding(.top, 24)
                    
                    // MARK: - Welcome Text
                    Text("splash.welcome_message".localized)
                        .font(.system(.subheadline, design: .serif).weight(.medium))
                        .foregroundColor(Color("Moss"))
                        .multilineTextAlignment(.center)
                        .lineSpacing(3)
                        .padding(.horizontal, 24)
                        .frame(minHeight: 50)
                    
                    // Divider
                    DiamondDivider(color: Color("Moss"))
                        .padding(.horizontal, 40)
                    
                    // MARK: - Name Input
                    VStack(spacing: 12) {
                        Text("splash.enter_name".localized)
                            .font(.system(.caption, design: .monospaced).weight(.medium))
                            .foregroundColor(Color("Moss").opacity(0.7))
                            .tracking(1)
                        
                        TextField("splash.name_placeholder".localized, text: $nameInput)
                            .font(.system(.body, design: .serif))
                            .foregroundColor(Color("Moss"))
                            .multilineTextAlignment(.center)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 16)
                            .background(Color("Beige").opacity(0.5))
                            .overlay(
                                Rectangle()
                                    .stroke(Color("Moss").opacity(0.3), lineWidth: 1)
                            )
                            .frame(maxWidth: panelWidth - 80)
                            .focused($isNameFieldFocused)
                            .submitLabel(.done)
                            .onSubmit {
                                if canProceed { proceed() }
                            }
                            .accessibilityLabel("splash.name_accessibility".localized)
                            .accessibilityHint("splash.name_hint".localized)
                            .onChange(of: nameInput) { _ in
                                let shouldShow = canProceed
                                if showButton != shouldShow {
                                    withAnimation(.easeOut(duration: 0.2)) {
                                        showButton = shouldShow
                                    }
                                }
                            }
                    }
                    
                    // MARK: - Proceed Button
                    if showButton && canProceed {
                        CustomButton(
                            title: "splash.begin".localized,
                            textColor: Color("Beige"),
                            buttonColor: Color("Moss")
                        ) {
                            proceed()
                        }
                        .customedBorder(
                            borderShape: "panel-border-005",
                            borderColor: Color("Gold"),
                            buttonType: .mainButton
                        )
                        .accessibilityLabel("splash.begin_accessibility".localized)
                    }
                    
                    // Bottom ornament
                    DotRow(color: Color("Moss"), count: 9, dotSize: 3)
                        .padding(.bottom, 20)
                }
            }
        }
        .customedBorder(
            borderShape: "panel-border-003",
            borderColor: Color("Moss"),
            buttonType: .customed(width: panelWidth, height: panelHeight)
        )
    }
    
    // MARK: - Actions
    private func proceed() {
        let trimmed = nameInput.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        playerName = trimmed
        isNameFieldFocused = false
        navigateToRegion = true
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        SplashScreenView()
    }
}
