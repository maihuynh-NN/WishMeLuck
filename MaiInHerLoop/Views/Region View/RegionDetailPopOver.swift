//
//  RegionDetailPopOver.swift
//  MaiInHerLoop
//
//  Created by Huynh Ngoc Nhat Mai on 17/2/26.
//
import SwiftUI

struct RegionDetailPopOver: View {
    let region: Region
    let onClose: () -> Void
    let onNavigate: () -> Void
    
    @State private var textOpacity = 0.0
    @State private var headerPulse = false
    @State private var currentGuideIndex = 0
    @State private var showRiskBriefing = false
   
    private var survivalGuide: RegionSurvivalGuide {
        switch region.name {
        case "North":
            return RegionSurvivalGuide.northGuide
        case "Central":
            return RegionSurvivalGuide.centralGuide
        case "South":
            return RegionSurvivalGuide.southGuide
        default:
            return RegionSurvivalGuide.northGuide
        }
    }
    
    private var regionKey: String {
        switch region.name {
        case "North":   return "north"
        case "Central": return "central"
        case "South":   return "south"
        default:        return "north"
        }
    }
    
    private var localizedRegionName: String {
        switch region.name {
        case "North":   return "region.north.name".localized
        case "Central": return "region.central.name".localized
        case "South":   return "region.south.name".localized
        default:        return region.name
        }
    }
    
    private var riskBriefingText: String {
        switch region.name {
        case "North": return "region.north.riskBriefing".localized
        case "Central": return "region.central.riskBriefing".localized
        case "South": return "region.south.riskBriefing".localized
        default: return ""
        }
    }
    
    private func sectionKey(_ index: Int, _ field: String) -> String {
           let section = survivalGuide.survivalSections[index - 1]
           switch field {
           case "title":    return section.titleKey.localized
           case "content":  return section.contentKey.localized
           case "subtitle": return section.subtitleKey.localized
           default:         return ""
           }
       }
    
    private var theRegionText: String {
        String(
            format: "ui.the_region".localized, 
            localizedRegionName.uppercased(with: Locale.current)
        )
    }
    
    private var readyTrialsText: String {
        String(
            format: "ui.ready_to_face_trials".localized,
            localizedRegionName
        )
    }
    
    var body: some View {
        ZStack {
            Color("Beige3")
               .ignoresSafeArea(.all)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    
                    // MARK: - Header Decorative Pattern
                    VStack(spacing: 8) {
                        HStack(spacing: 4) {
                            ForEach(0..<7, id: \.self) { _ in
                                Rectangle()
                                    .fill(Color("Red").opacity(0.7))
                                    .frame(width: 3, height: 12)
                            }
                        }
                        .padding(.bottom, 10)
                        .chronicleFade()
                        
                        // MARK: - Top Image with Text
                        ZStack {
                            CustomCard(
                                image: region.name,
                                borderColor: Color("Red"),
                                size: .customed(width: 320, height: 220)
                            ) {}
                            
                            VStack {
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("ui.landing_on".localized)
                                            //.font(.system(size: 10, weight: .bold, design: .monospaced))
                                            .foregroundColor(.white)
                                            .tracking(1)
                                        
                                        Text(theRegionText)
                                            //.font(AppFontStyle.secondTitle.font)
                                            .foregroundColor(.white)
                                            .tracking(1.5)
                                            .opacity(headerPulse ? 1.0 : 0.8)
                                        
                                        Text("ui.survival_orientation_manual".localized)
                                            //.font(.system(size: 9, weight: .medium, design: .monospaced))
                                            .foregroundColor(.white.opacity(0.9))
                                            .tracking(0.5)
                                    }
                                    
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.top, 30)
                                
                                Spacer()
                            }
                            .frame(width: 320, height: 220)
                        }
                    }
                    
                    // MARK: - Cultural Divider
                    HStack {
                        Rectangle()
                            .fill(Color("Red").opacity(0.6))
                            .frame(height: 1)
                        
                        Text("◆")
                            .font(.system(size: 10))
                            .foregroundColor(Color("Red"))
                        
                        Rectangle()
                            .fill(Color("Red").opacity(0.6))
                            .frame(height: 1)
                    }
                    .padding(.horizontal, 50)
                    .opacity(textOpacity)
                    
                    // MARK: - Risk Briefing with Typewriter Effect
                    VStack(spacing: 12) {
                        if showRiskBriefing {
                            Text("")
                                .typewriter(riskBriefingText, speed: 0.04) 
                                //.font(.system(size: 11, weight: .medium, design: .serif))
                                .foregroundColor(Color("Red"))
                                .italic()
                                .multilineTextAlignment(.center)
                                .lineSpacing(2)
                                .padding(.horizontal, 30)
                                .frame(maxWidth: 300)
                        }
                        
                        // Dots pattern
                        HStack(spacing: 6) {
                            ForEach(0..<9, id: \.self) { _ in
                                Circle()
                                    .fill(Color("Red").opacity(0.6))
                                    .frame(width: 3, height: 3)
                            }
                        }
                    }
                    .padding(.vertical, 10)
                     
                    HStack {
                        Rectangle()
                            .fill(Color("Red").opacity(0.6))
                            .frame(height: 1)
                        
                        Text("◆")
                            .font(.system(size: 10))
                            .foregroundColor(Color("Red"))
                        
                        Rectangle()
                            .fill(Color("Red").opacity(0.6))
                            .frame(height: 1)
                    }
                    .padding(.horizontal, 50)
                    .opacity(textOpacity)
                    
                    // MARK: - Chronicle Header with Traditional Pattern
                    VStack(spacing: 8) {
                        Text("ui.chronicles.title".localized)
                            .font(.system(size: 12, weight: .bold, design: .monospaced))
                            .foregroundColor(Color("Red"))
                            .tracking(2)
                            .opacity(textOpacity)
                        
                        // Chevron pattern
                        HStack(spacing: 2) {
                            ForEach(0..<8, id: \.self) { _ in
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 8, weight: .bold))
                                    .foregroundColor(Color("Red"))
                            }
                        }
                        .opacity(textOpacity)
                    }
                    .padding(.top, 10)
                    
                    // MARK: - Survival Sections
                    VStack(spacing: 25) {
                        ForEach(Array(survivalGuide.survivalSections.enumerated()), id: \.offset) { index, section in
                            let idx = index + 1 // 1-based cho key
                            HStack {
                                if index % 2 == 0 {
                                    VStack(alignment: .leading, spacing: 8) {
                                        HStack(spacing: 12) {
                                           
                                            VStack(spacing: 2) {
                                                Rectangle()
                                                    .fill(Color("Gold").opacity(0.9))
                                                    .frame(width: 12, height: 2)
                                                Rectangle()
                                                    .fill(Color("Gold").opacity(0.7))
                                                    .frame(width: 10, height: 2)
                                                Rectangle()
                                                    .fill(Color("Gold").opacity(0.5))
                                                    .frame(width: 8, height: 2)
                                                Rectangle()
                                                    .frame(width: 4, height: 2)
                                            }
                                            
                                            VStack(alignment: .leading, spacing: 6) {
                                                Text(sectionKey(idx, "title"))
                                                    .font(.system(size: 12, weight: .bold, design: .monospaced))
                                                    .foregroundColor(Color("Gold"))
                                                    .tracking(0.8)
                                                
                                                Text(sectionKey(idx, "content"))
                                                    .font(.system(size: 10, weight: .medium, design: .serif))
                                                    .foregroundColor(Color("Gold"))
                                                    .multilineTextAlignment(.leading)
                                                    .lineSpacing(1.5)
                                                
                                                Text(sectionKey(idx, "subtitle"))
                                                    .font(.system(size: 9, weight: .medium, design: .serif))
                                                    .foregroundColor(Color("Gold").opacity(0.8))
                                                    .italic()
                                                    .multilineTextAlignment(.leading)
                                                    .padding(.top, 4)
                                                    .bold()
                                                    .italic()
                                            }
                                        }
                                    }
                                    .frame(maxWidth: 230)
                                    .staggeredAppear(delay: Double(index) * 0.3)
                                    
                                    Spacer()
                                } else {
                                    
                                    Spacer()
                                    
                                    VStack(alignment: .trailing, spacing: 8) {
                                        HStack(spacing: 12) {
                                            VStack(alignment: .trailing, spacing: 6) {
                                                Text(sectionKey(idx, "title"))
                                                    .font(.system(size: 12, weight: .bold, design: .monospaced))
                                                    .foregroundColor(Color("Gold"))
                                                    .tracking(0.8)
                                                
                                                Text(sectionKey(idx, "content"))
                                                    .font(.system(size: 10, weight: .medium, design: .serif))
                                                    .foregroundColor(Color("Gold"))
                                                    .multilineTextAlignment(.trailing)
                                                    .lineSpacing(1.5)
                                                
                                                Text(sectionKey(idx, "subtitle"))
                                                    .font(.system(size: 9, weight: .medium, design: .serif))
                                                    .foregroundColor(Color("Gold").opacity(0.8))
                                                    .multilineTextAlignment(.trailing)
                                                    .padding(.top, 4)
                                                    .bold()
                                                    .italic()
                                            }
                                            
                                            VStack(spacing: 2) {
                                                Rectangle()
                                                    .fill(Color("Gold").opacity(0.9))
                                                    .frame(width: 10, height: 2)
                                                Rectangle()
                                                    .fill(Color("Gold").opacity(0.7))
                                                    .frame(width: 8, height: 2)
                                                Rectangle()
                                                    .fill(Color("Gold").opacity(0.5))
                                                    .frame(width: 6, height: 2)
                                                Rectangle()
                                                    .fill(Color("Gold").opacity(0.3))
                                                    .frame(width: 4, height: 2)
                                            }
                                        }
                                    }
                                    .frame(maxWidth: 230)
                                    .staggeredAppear(delay: Double(index) * 0.3)
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    .padding(.vertical, 15)
                    
                    // MARK: - Final Ceremonial Pattern
                    VStack(spacing: 12) {
                        //  pattern threat bars
                        VStack(spacing: 8) {
                            HStack(spacing: 3) {
                                ForEach(0..<5, id: \.self) { i in
                                    Rectangle()
                                        .fill(Color("Gold").opacity(0.8 - Double(i) * 0.1))
                                        .frame(width: 16, height: 24)
                                }
                            }
                            
                            HStack {
                                Rectangle()
                                    .fill(Color("Gold").opacity(0.6))
                                    .frame(height: 1)
                                
                                Text("∎")
                                    .font(.system(size: 10))
                                    .foregroundColor(Color("Gold"))
                                
                                Rectangle()
                                    .fill(Color("Gold").opacity(0.6))
                                    .frame(height: 1)
                            }
                            .padding(.horizontal, 60)

                        }
                        .opacity(textOpacity)
                        
                        Text(readyTrialsText)
                            .font(.system(size: 11, weight: .medium, design: .serif))
                            .foregroundColor(Color("Gold"))
                            .italic()
                            .opacity(textOpacity)
                            .padding(.top, 8)
                        
                        CustomButton(
                            title: "ui.enter_region".localized,
                            textColor: Color("Moss"),
                            buttonColor: Color("Gold")
                        ) {
                            onNavigate()
                        }
                        .customedBorder(borderShape: "panel-border-003", borderColor: Color("Gold"), buttonType: .mainButton)
                        //.buttonPress()
                        .padding(.top, 5)
                        
                        Button(action: onClose) {
                            Text("ui.study_others_first".localized)
                                .font(.system(size: 9, weight: .light, design: .monospaced))
                                .foregroundColor(Color("Gold").opacity(0.7))
                                .tracking(0.5)
                                .underline()
                        }
                    }
                    .padding(.bottom, 30)
                }
                .padding(.top, 20)
            }
        }
        .overlayAppear()
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                headerPulse = true
            }
            
            withAnimation(.easeIn(duration: 1.0).delay(0.5)) {
                textOpacity = 1.0
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                showRiskBriefing = true
            }
        }
    }
}

#Preview {
    NavigationStack {
        RegionSelectionView()
    }
}
