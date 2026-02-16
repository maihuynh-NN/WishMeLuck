//
//  RegionSelectionView.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 9/2/26.
//

import SwiftUI

let regions: [Region] = [
    Region(region_id: 1, name: "South", story: "Fertile delta lands where monsoons bring both blessing and devastation."),
    Region(region_id: 2, name: "North", story: "Ancient mountains harbor storms that test the wisdom of ancestors."),
    Region(region_id: 3, name: "Central", story: "Coastal highlands where typhoons write their chronicles in stone.")
]

private extension String {
    var localized: String { NSLocalizedString(self, comment: "") }
    var lkey: LocalizedStringKey { LocalizedStringKey(self) }
}

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
                            .fill(Color("Primary").opacity(0.6))
                            .frame(height: 1)
                            .padding(.leading, 50)
                        
                        Text("∎")
                            .font(.system(size: 8))
                            .foregroundColor(Color("Primary"))
                        
                        Rectangle()
                            .fill(Color("Primary").opacity(0.6))
                            .frame(height: 1)
                    }
                    .padding(.horizontal, 50)
                    
                    Text("regionselect.subtitle".lkey) // "Choose the land where you will face the trials of nature"
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(Color("Secondary2"))
                        .multilineTextAlignment(.center)
                        .lineSpacing(2)
                        .padding(.horizontal, 40)
                        .opacity(textOpacity)
                }
                .padding(.bottom, 15)
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
