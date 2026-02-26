//
//  RegionSelectionView.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 9/2/26.
//

import SwiftUI

struct RegionSelectionView: View {
    
    @AppStorage("selectedLanguage") private var language = "en"
    @State private var selection = 0
    @State private var selectedRegion: Region? = nil
    @State private var currentRegion: Region? = nil
    @State private var showDifficultySelector: Bool = false
    @State private var textOpacity = 0.0
    @State private var headerPulse = false
    
    // MARK: - Responsive
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    private var isWide: Bool { horizontalSizeClass == .regular }
    private var cardAreaHeight: CGFloat { isWide ? 640 : 493 }
    
    var body: some View {
        ZStack {
            
            // Background layer
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .accessibilityHidden(true)
            
            VStack(spacing: 0) {
                // Top spacer — smaller on iPad so header isn't pushed too low
                Spacer().frame(maxHeight: isWide ? 250 : .infinity)
                
                // MARK: - Cultural Header
                VStack(spacing: 15) {
                    // Traditional pattern line
                    HStack(spacing: 4) {
                        ForEach(0..<7, id: \.self) { _ in
                            Rectangle()
                                .fill(Color("Red3").opacity(0.7))
                                .frame(width: 3, height: 12)
                        }
                    }
                    .padding(.horizontal, 35)
                    .opacity(textOpacity)
                    
                    VStack(spacing: 8) {
                        Text("region.title".localized)
                        //.font(.system(size: 18, weight: .black, design: .monospaced))
                            .foregroundColor(Color("Red3"))
                            .tracking(2)
                            .opacity(headerPulse ? 1.0 : 0.8)
                        
                    }
                    
                    HStack {
                        Rectangle()
                            .fill(Color("Red3").opacity(0.6))
                            .frame(height: 1)
                            .padding(.leading, 50)
                        
                        Text("∎")
                            .font(.system(size: 8))
                            .foregroundColor(Color("Red3"))
                        
                        Rectangle()
                            .fill(Color("Red3").opacity(0.6))
                            .frame(height: 1)
                    }
                    .padding(.horizontal, 50)
                    
                    Text("region.subtitle".localized)
                        //.font(.system(size: 10, weight: .medium))
                        .foregroundColor(Color("Red3"))
                        .multilineTextAlignment(.center)
                        .lineSpacing(2)
                        .padding(.horizontal, 40)
                        .opacity(textOpacity)
                }
                .padding(.bottom, 15)
                
                // MARK: - Region Selection Area
                VStack(spacing: 20) {
                    TabView(selection: $selection) {
                        ForEach(Array(regions.enumerated()), id: \.element.region_id) { index, region in
                            ScaledRegionCard(
                                region: region,
                                index: index,
                                selectedRegion: $selectedRegion
                            )
                            .staggeredAppear(delay: Double(index) * 0.2)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .frame(height: cardAreaHeight)
                    
                    // MARK: - Navigation Indicators
                    HStack(spacing: 8) {
                        ForEach(0..<regions.count, id: \.self) { index in
                            Rectangle()
                                .fill(selection == index ? Color("Red3") : Color("Red3").opacity(0.3))
                                .frame(
                                    width: selection == index ? 20 : 8,
                                    height: selection == index ? 4 : 3
                                )
                                .animation(.easeInOut(duration: 0.3), value: selection)
                        }
                    }
                }
                .padding(.bottom, 15)
                
                // MARK: - Action Panel
                VStack(spacing: 10) {
                    // Decorative pattern at bottom
                    HStack(spacing: 4) {
                        ForEach(0..<7, id: \.self) { _ in
                            Circle()
                                .fill(Color("Red3").opacity(0.6))
                                .frame(width: 2, height: 2)
                        }
                    }
                    .padding(.vertical, 4)
                    .opacity(textOpacity)
                    
                    // Action button
                        CustomButton(
                            title: "region.title".localized,
                            textColor: Color("Beige"),
                            buttonColor: Color("Red3")
                        ) {
                            let selectedRegion = regions[selection]
                            self.currentRegion = selectedRegion
                            showDifficultySelector = true
                            
                        }
                        .customedBorder(borderShape: "panel-border-003", borderColor: Color("Gold3"), buttonType: .mainButton)
                    }
                
                Spacer()
    
            }
        }
        .navigationDestination(isPresented: $showDifficultySelector) {
            if let region = currentRegion {
                ScenarioListView(region: region)
            }
        }
        

        .sheet(item: $selectedRegion) { region in
            RegionDetailPopOver(
                region: region,
                onClose: { selectedRegion = nil },
                onNavigate: {
                    currentRegion = region
                    selectedRegion = nil
                    showDifficultySelector = true
                }
            )
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
        .onAppear {
            withAnimation(.easeIn(duration: 1.2).delay(0.5)) {
                textOpacity = 1.0
            }
        }
    }
}

#Preview {
    NavigationStack {
        RegionSelectionView()
    }
}
