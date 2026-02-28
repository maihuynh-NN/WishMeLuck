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
        GeometryReader { geo in
            ZStack {
                
                Image("Background")
                    .resizable()
                    .clipped()
                    .ignoresSafeArea(edges: .vertical)
                    .accessibilityHidden(true)
                
                VStack(spacing: 0) {
                    Spacer().frame(maxHeight: isWide ? 10 : .infinity)
                    
                    // MARK: - Header
                    VStack(spacing: 15) {
                        HStack(spacing: 4) {
                            ForEach(0..<7, id: \.self) { _ in
                                Rectangle()
                                    .fill(Color("Red3"))
                                    .frame(width: 3, height: 12)
                            }
                        }
                        .padding(.horizontal, 35)
                        .opacity(textOpacity)
                        .accessibilityHidden(true)
                        
                        VStack(spacing: 8) {
                            Text("region.title.mini".localized)
                                .font(.system(.caption2, design: .monospaced).weight(.bold))
                                .foregroundColor(Color("Red3"))
                                .tracking(2)
                                .opacity(headerPulse ? 1.0 : 0.8)
                                .accessibilityAddTraits(.isHeader)
                            
                            Text("region.title".localized)
                                .font(.system(.title2, design: .monospaced).weight(.black))
                                .foregroundColor(Color("Red3"))
                                .tracking(2)
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(headerPulse ? 1.0 : 0.8)
                                .accessibilityAddTraits(.isHeader)
                        }
                        
                        HStack {
                            Rectangle()
                                .fill(Color("Red3"))
                                .frame(height: 1)
                                .padding(.leading, 50)
                            
                            Text("∎")
                                .font(.system(.caption2))
                                .foregroundColor(Color("Red3"))
                            
                            Rectangle()
                                .fill(Color("Red3"))
                                .frame(height: 1)
                                .padding(.trailing, 50)
                        }
                        .padding(.horizontal, 50)
                        .accessibilityHidden(true)
                        
                        Text("region.subtitle".localized)
                            .font(.system(.caption2, design: .monospaced).weight(.medium))
                            .foregroundColor(Color("Moss"))
                            .multilineTextAlignment(.center)
                            .lineSpacing(2)
                            .padding(.horizontal, 40)
                            .opacity(textOpacity)
                    }
                    .padding(.bottom, 10)
                    
                    // MARK: - Region Selection Area
                    VStack(spacing: 15) {
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
                                    .fill(selection == index ? Color("Gold3") : Color("Gold3").opacity(0.3))
                                    .frame(
                                        width: selection == index ? 20 : 8,
                                        height: selection == index ? 4 : 3
                                    )
                                    .animation(.easeInOut(duration: 0.3), value: selection)
                            }
                        }
                        .accessibilityHidden(true)
                    }
                    
                    // MARK: - Action Panel
                    VStack(spacing: 8) {
                        HStack(spacing: 4) {
                            ForEach(0..<7, id: \.self) { _ in
                                Circle()
                                    .fill(Color("Red3").opacity(0.6))
                                    .frame(width: 2, height: 2)
                            }
                        }
                        .padding(.vertical, 2)
                        .opacity(textOpacity)
                        .accessibilityHidden(true)
                        
                        CustomButton(
                            title: "regionselect.selectButton".localized,
                            textColor: Color("Beige"),
                            buttonColor: Color("Red3")
                        ) {
                            let selectedRegion = regions[selection]
                            self.currentRegion = selectedRegion
                            showDifficultySelector = true
                        }
                        .customedBorder(borderShape: "panel-border-008", borderColor: Color("Gold3"), buttonType: .mainButton)
                    }
                    .padding(.bottom, 50)
                }
                
                // MARK: - Back Button
                BackButton(iconColor: Color("Red3"), borderColor: Color("Gold3"))
                
                // MARK: - Settings Button 
                SettingsButton()
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
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
