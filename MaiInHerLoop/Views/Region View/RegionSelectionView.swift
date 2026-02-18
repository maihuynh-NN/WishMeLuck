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
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // Top spacer for centering
                Spacer()
                
                // MARK: - Cultural Header
                VStack(spacing: 15) {
                    // Traditional pattern line
                    HStack(spacing: 4) {
                        ForEach(0..<7, id: \.self) { _ in
                            Rectangle()
                                .fill(Color("Moss").opacity(0.7))
                                .frame(width: 3, height: 12)
                        }
                    }
                    .padding(.horizontal, 35)
                    .opacity(textOpacity)
                    
                    VStack(spacing: 8) {
                        Text("region.title".lkey)
                        //.font(.system(size: 18, weight: .black, design: .monospaced))
                            .foregroundColor(Color("Moss"))
                            .tracking(2)
                            .opacity(headerPulse ? 1.0 : 0.8)
                        
                    }
                    
                    HStack {
                        Rectangle()
                            .fill(Color("Moss").opacity(0.6))
                            .frame(height: 1)
                            .padding(.leading, 50)
                        
                        Text("∎")
                            .font(.system(size: 8))
                            .foregroundColor(Color("Moss"))
                        
                        Rectangle()
                            .fill(Color("Moss").opacity(0.6))
                            .frame(height: 1)
                    }
                    .padding(.horizontal, 50)
                    
                    Text("region.subtitle".lkey)
                        //.font(.system(size: 10, weight: .medium))
                        .foregroundColor(Color("Moss"))
                        .multilineTextAlignment(.center)
                        .lineSpacing(2)
                        .padding(.horizontal, 40)
                        //.opacity(textOpacity)
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
                    .frame(height: 493)
                    
                    // MARK: - Navigation Indicators
                    HStack(spacing: 8) {
                        ForEach(0..<regions.count, id: \.self) { index in
                            Rectangle()
                                .fill(selection == index ? Color("Moss") : Color("Moss").opacity(0.3))
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
                                .fill(Color("Moss").opacity(0.6))
                                .frame(width: 2, height: 2)
                        }
                    }
                    .padding(.vertical, 4)
                    .opacity(textOpacity)
                    
                    // Action button
                        CustomButton(
                            title: "region.title".lkey,
                            textColor: Color("Moss"),
                            buttonColor: Color("Gold")
                        ) {
                            let selectedRegion = regions[selection]
                            self.currentRegion = selectedRegion
                            showDifficultySelector = true
                            
                            VStack {
                                Text("regionselect.selectButton".lkey)
                                //.font(.system(size: 8, weight: .bold, design: .monospaced))
                                    .foregroundColor(Color("Moss"))
                                    .tracking(0.8)
                                
                                Text(regions[selection].name.uppercased())
                                //.font(.system(size: 14, weight: .black, design: .monospaced))
                                    .foregroundColor(Color("Gold"))
                                    .tracking(1.2)
                            }
                        }
                        .customedBorder(borderShape: "panel-border-003", borderColor: Color("Moss"), buttonType: .mainButton)
                        //.buttonPress()
                        .emergencyPulse()
                    }
                
                Spacer()
    
            }
            
            // MARK: - Region Detail popover (rendered as an in-ZStack overlay)
            if let region = selectedRegion {
                RegionDetailPopOver(
                    region: region,
                    onClose: { selectedRegion = nil },
                    onNavigate: {
                        currentRegion = region
                        selectedRegion = nil
                        showDifficultySelector = true
                    }
                )
            }
        }
    }
}

#Preview {
    RegionSelectionView()
}
        
//        VStack(spacing: 32) {
//            // Title
//            VStack(spacing: 8) {
//                Text(titleText)
//                    .font(.title.bold())
//                
//                Text(subtitleText)
//                    .font(.subheadline)
//                    .foregroundColor(.secondary)
//            }
//            .padding(.top, 40)
//            
//            // Region cards carousel
//            TabView(selection: $selectedRegion) {
//                RegionCard(
//                    region: "north",
//                    icon: "cloud.rain.fill",
//                    nameEN: "Northern Vietnam",
//                    nameVI: "Miền Bắc",
//                    descriptionEN: "Floods and landslides from heavy rainfall",
//                    descriptionVI: "Lũ lụt và sạt lở đất từ mưa lớn",
//                    language: language
//                )
//                .tag("north")
//                
//                RegionCard(
//                    region: "central",
//                    icon: "wind",
//                    nameEN: "Central Vietnam",
//                    nameVI: "Miền Trung",
//                    descriptionEN: "Typhoons and coastal storm surges",
//                    descriptionVI: "Bão và sóng lớn ven biển",
//                    language: language
//                )
//                .tag("central")
//                
//                RegionCard(
//                    region: "south",
//                    icon: "sun.max.fill",
//                    nameEN: "Southern Vietnam",
//                    nameVI: "Miền Nam",
//                    descriptionEN: "Droughts and river flooding",
//                    descriptionVI: "Hạn hán và lũ sông",
//                    language: language
//                )
//                .tag("south")
//            }
//            .tabViewStyle(.page(indexDisplayMode: .always))
//            .frame(height: 400)
//            
//            // Mission Aboard button - CHANGED to destination-based navigation
//            NavigationLink(destination: ScenarioListView(region: selectedRegion)) {
//                Text(missionButtonText)
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(Color.blue)
//                    .cornerRadius(12)
//            }
//            .padding(.horizontal, 40)
//            
//            Spacer()
//        }
//        .navigationBarBackButtonHidden(false)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                NavigationLink(destination: DiaryListView()) {  // CHANGED
//                    Image(systemName: "book.fill")
//                }
//            }
//        }
//    }
//    
//    // MARK: - Localized Text
//    
//    private var titleText: String {
//        language == "vi" ? "Chọn Khu Vực" : "Choose Your Region"
//    }
//    
//    private var subtitleText: String {
//        language == "vi"
//        ? "Vuốt để khám phá các thiên tai khác nhau"
//        : "Swipe to explore different disasters"
//    }
//    
//    private var missionButtonText: String {
//        language == "vi" ? "Bắt Đầu Nhiệm Vụ" : "Mission Aboard"
//    }
//}
//
//// MARK: - Region Card Component
//
//struct RegionCard: View {
//    let region: String
//    let icon: String
//    let nameEN: String
//    let nameVI: String
//    let descriptionEN: String
//    let descriptionVI: String
//    let language: String
//    
//    var body: some View {
//        VStack(spacing: 24) {
//            // Icon
//            Image(systemName: icon)
//                .font(.system(size: 80))
//                .foregroundColor(.blue)
//            
//            // Region name
//            Text(language == "vi" ? nameVI : nameEN)
//                .font(.title.bold())
//            
//            // Description
//            Text(language == "vi" ? descriptionVI : descriptionEN)
//                .font(.body)
//                .foregroundColor(.secondary)
//                .multilineTextAlignment(.center)
//                .padding(.horizontal, 40)
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(
//            RoundedRectangle(cornerRadius: 20)
//                .fill(Color.blue.opacity(0.1))
//        )
//        .padding(.horizontal, 20)
//    }
//}

//#Preview {
//    NavigationStack {
//        RegionSelectionView()
//    }
//}
//
//#Preview("Vietnamese") {
//    NavigationStack {
//        RegionSelectionView()
//            .onAppear {
//                UserDefaults.standard.set("vi", forKey: "selectedLanguage")
//            }
//    }
//}
